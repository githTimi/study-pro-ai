import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_pro/main_nav_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _signInEmailController = TextEditingController();
  final _signInPasswordController = TextEditingController();

  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _signInEmailController.dispose();
    _signInPasswordController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  double pageSpace(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 20;
    if (width < 600) return 28;
    return 40;
  }

  double titleSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 28;
    if (width < 600) return 34;
    return 42;
  }

  double bodySize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 14;
    if (width < 600) return 16;
    return 18;
  }

  double inputHeight(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width < 600 ? 58 : 64;
  }

  double buttonHeight(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width < 600 ? 54 : 60;
  }

  Future<void> _signInWithEmail() async {
    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _signInEmailController.text.trim(),
        password: _signInPasswordController.text.trim(),
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _errorText = e.message ?? 'Sign in failed.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signUpWithEmail() async {
    if (_signUpPasswordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      setState(() => _errorText = 'Passwords do not match.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _signUpEmailController.text.trim(),
        password: _signUpPasswordController.text.trim(),
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _errorText = e.message ?? 'Sign up failed.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _errorText = e.message ?? 'Google sign-in failed.');
    } catch (e) {
      setState(() => _errorText = 'Google sign-in cancelled or failed.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  InputDecoration _inputDecoration(BuildContext context, String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: const Color(0xFF9A95A8),
        fontSize: bodySize(context),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE2DBEC), width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE2DBEC), width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF842CD3), width: 1.4),
      ),
    );
  }

  Widget _buildEmailField(
    BuildContext context, {
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
  }) {
    return SizedBox(
      height: inputHeight(context),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(
          fontSize: bodySize(context),
          color: const Color(0xFF2F2340),
        ),
        decoration: _inputDecoration(context, hint),
      ),
    );
  }

  Widget _buildPrimaryButton(
    BuildContext context, {
    required String text,
    required VoidCallback? onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: buttonHeight(context),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFF5B63F6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: bodySize(context),
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }

  Widget _buildGoogleButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: buttonHeight(context),
      child: OutlinedButton.icon(
        onPressed: _isLoading ? null : _signInWithGoogle,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF342C63),
          side: const BorderSide(color: Color(0xFFE2DBEC), width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          backgroundColor: Colors.white,
        ),
        icon: const Icon(Icons.login),
        label: Text(
          'Continue with Google',
          style: TextStyle(
            fontSize: bodySize(context),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final space = pageSpace(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(space),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: space),
              Text(
                'Welcome to\nScholar Sanctuary',
                style: TextStyle(
                  fontSize: titleSize(context),
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                  color: const Color(0xFF342C63),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Sign in or create an account to save your summaries, quizzes, and study sessions.',
                style: TextStyle(
                  fontSize: bodySize(context),
                  color: const Color(0xFF7E739B),
                  height: 1.5,
                ),
              ),
              SizedBox(height: space),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(space),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: const Color(0xFF5B63F6),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: const Color(0xFF6F6488),
                        dividerColor: Colors.transparent,
                        tabs: const [
                          Tab(text: 'Sign In'),
                          Tab(text: 'Sign Up'),
                        ],
                      ),
                    ),
                    SizedBox(height: space),

                    SizedBox(
                      height: MediaQuery.sizeOf(context).width < 600
                          ? 360
                          : 420,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Column(
                            children: [
                              _buildEmailField(
                                context,
                                controller: _signInEmailController,
                                hint: 'Email',
                              ),
                              const SizedBox(height: 14),
                              _buildEmailField(
                                context,
                                controller: _signInPasswordController,
                                hint: 'Password',
                                obscure: true,
                              ),
                              const SizedBox(height: 18),
                              _buildPrimaryButton(
                                context,
                                text: 'Sign In',
                                onTap: _isLoading ? null : _signInWithEmail,
                              ),
                              const SizedBox(height: 14),
                              _buildGoogleButton(context),
                            ],
                          ),
                          Column(
                            children: [
                              _buildEmailField(
                                context,
                                controller: _signUpEmailController,
                                hint: 'Email',
                              ),
                              const SizedBox(height: 14),
                              _buildEmailField(
                                context,
                                controller: _signUpPasswordController,
                                hint: 'Password',
                                obscure: true,
                              ),
                              const SizedBox(height: 14),
                              _buildEmailField(
                                context,
                                controller: _confirmPasswordController,
                                hint: 'Confirm Password',
                                obscure: true,
                              ),
                              const SizedBox(height: 18),
                              _buildPrimaryButton(
                                context,
                                text: 'Create Account',
                                onTap: _isLoading ? null : _signUpWithEmail,
                              ),
                              const SizedBox(height: 14),
                              _buildGoogleButton(context),
                            ],
                          ),
                        ],
                      ),
                    ),

                    if (_errorText != null) ...[
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _errorText!,
                          style: TextStyle(
                            color: const Color(0xFFD32F2F),
                            fontSize: bodySize(context) - 1,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
