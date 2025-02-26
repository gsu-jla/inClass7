import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimationPages(),
    );
  }
}

class AnimationPages extends StatefulWidget {
  @override
  _AnimationPagesState createState() => _AnimationPagesState();
}

class _AnimationPagesState extends State<AnimationPages> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            FadingTextAnimation(
              duration: Duration(seconds: 1),
              title: 'Fading Animation 1',
            ),
            FadingTextAnimation(
              duration: Duration(seconds: 3),
              title: 'Fading Animation 2',
            ),
          ],
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 2; i++)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == _currentPage ? Colors.blue : Colors.grey,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final Duration duration;
  final String title;

  FadingTextAnimation({
    required this.duration,
    required this.title,
  });

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

// icon list setup
const List<Widget> icons = <Widget>[Icon(Icons.sunny), Icon(Icons.mode_night_outlined)];

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  Color _textColor = Colors.black;
  bool _isDarkMode = false;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildColorButton(Colors.black),
                _buildColorButton(Colors.red),
                _buildColorButton(Colors.blue),
                _buildColorButton(Colors.green),
                _buildColorButton(Colors.yellow),
                _buildColorButton(Colors.purple),
                _buildColorButton(Colors.orange),
                _buildColorButton(Colors.pink),
                _buildColorButton(Colors.teal),
                _buildColorButton(Colors.indigo),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _textColor = color;
        });
        Navigator.of(context).pop();
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            // Color picker button
            IconButton(
              icon: const Icon(Icons.color_lens),
              onPressed: _showColorPicker,
              tooltip: 'Change Text Color',
            ),
            // Theme toggle button
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: toggleTheme,
              tooltip: _isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            ),
          ],
        ),
        body: Center(
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: widget.duration,
            curve: Curves.easeInOut,
            child: Text(
              'Hello, Flutter!',
              style: TextStyle(
                fontSize: 24,
                color: _textColor,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: toggleVisibility,
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
