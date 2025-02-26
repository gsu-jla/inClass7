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

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  // var for toggle buttons
  final List<bool> _selectedWeather = <bool>[true, false];
  bool vertical = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          const SizedBox(height: 5),
              ToggleButtons(   //toggle for day-night
                direction: vertical ? Axis.vertical : Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < _selectedWeather.length; i++) {
                      _selectedWeather[i] = i == index;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.blue[700],
                selectedColor: Colors.white,
                fillColor: Colors.blue[200],
                color: Colors.blue[400],
                isSelected: _selectedWeather,
                children: icons,
              )
        ],
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: widget.duration,
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
