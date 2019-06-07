import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/models/app_state_model.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ObjectRecord>(
      converter: (store) => store.state.selectedObject,
      builder: (context, ObjectRecord selectedObject) {
        return Scaffold(
          appBar: AppBar(title: Text(selectedObject.name)),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          body: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 20.0,
                ),
                Container(
                  child: Text(
                    selectedObject.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 32,
                    ),
                  ),
                ),
                Container(
                  height: 40.0,
                ),
                Container(
                  child: Card(
                    child: Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            'assets/images/dogs/adult.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              'assets/images/dogs/puppy.jpg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      width: 50.0,
                      height: 50.0,
                      child: Icon(
                        Icons.forward,
                        color: Colors.blue,
                        size: 48.0,
                      ),
                    ),
                    Card(
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              'assets/images/dogs/adult.jpg',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
