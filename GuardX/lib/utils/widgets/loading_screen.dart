import '../../consts/index.dart';

class LoadingWidget extends StatefulWidget {
  final String message;

  LoadingWidget({Key? key, this.message = 'Loading Screen...'})
      : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}
 
class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/loading_img.gif',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20.0),
          Text(widget.message),
        ],
      ),
    );
  }
}
