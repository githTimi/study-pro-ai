import {onRequest} from "firebase-functions/v2/https";
import {defineSecret} from "firebase-functions/params";
import * as logger from "firebase-functions/logger";
import OpenAI from "openai";

const OPENAI_API_KEY = defineSecret("OPENAI_API_KEY");

export const generateSummary = onRequest(
  {
    secrets: [OPENAI_API_KEY],
    cors: true,
    invoker: "public",
  },
  async (req, res) => {
    try {
      if (req.method !== "POST") {
        res.status(405).json({error: "Method not allowed"});
        return;
      }

      const {content} = req.body ?? {};

      if (!content || typeof content !== "string" || !content.trim()) {
        res.status(400).json({error: "Missing content"});
        return;
      }

      const client = new OpenAI({
        apiKey: OPENAI_API_KEY.value(),
      });

      const systemPrompt =
        "You are an academic study assistant. Return valid JSON only " +
        "with this exact shape: " +
        "{\"title\": string, \"shortSummary\": string, " +
        "\"keyPoints\": string[], " +
        "\"importantTerms\": {\"term\": string, \"meaning\": string}[], " +
        "\"examTip\": string}";

      const response = await client.responses.create({
        model: "gpt-4.1-mini",
        input: [
          {
            role: "system",
            content: [
              {
                type: "input_text",
                text: systemPrompt,
              },
            ],
          },
          {
            role: "user",
            content: [
              {
                type: "input_text",
                text: `Summarize this study material:\n\n${content}`,
              },
            ],
          },
        ],
      });

      const rawText = response.output_text;

      let parsed;
      try {
        parsed = JSON.parse(rawText);
      } catch (parseError) {
        logger.error("Failed to parse OpenAI JSON", parseError);
        res.status(500).json({
          error: "Invalid AI response format",
          raw: rawText,
        });
        return;
      }
      res.status(200).json(parsed);
    } catch (error: unknown) {
      logger.error("generateSummary failed", error);

      res.status(500).json({
        error: "Failed to generate summary",
        details: error instanceof Error ? error.message : String(error),
      });
    }
  }
);


