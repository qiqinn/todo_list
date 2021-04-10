import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Tugas',
      home: new TodoList()
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}
class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];
  void _addTodoItem(String task) {
  if(task.length > 0) {
    setState(() => _todoItems.add(task));
  }
}

Widget build(BuildContext context) {
  return new Scaffold(
    appBar: new AppBar(
      backgroundColor: Colors.red,
      title: new Text('Daftar Tugas')
    ),
    body: _buildTodoList(),
    floatingActionButton: new FloatingActionButton(
      backgroundColor: Colors.green,
      onPressed: _pushAddTodoScreen, 
      tooltip: 'Tambahkan Tugas',
      child: new Icon(Icons.add)
    ),
  );
}

void _pushAddTodoScreen() {
  // Push this page onto the stack
  Navigator.of(context).push(
    // MaterialPageRoute will automatically animate the screen entry, as well
    // as adding a back button to close it
    new MaterialPageRoute(
      builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.lightGreen,
            title: new Text('Tambahkan sebuah tugas')
          ),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
              hintText: 'nama tugas',
              contentPadding: const EdgeInsets.all(16.0)
            ),
          )
        );
      }
    )
  );
}

void _removeTodoItem(int index) {
  setState(() => _todoItems.removeAt(index));
}

// Show an alert dialog asking the user to confirm that the task is done
void _promptRemoveTodoItem(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Apakah tugas "${_todoItems[index]}" telah dikerjakan?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('BATAL',
            style: TextStyle(
              color: Colors.black
            )),
            onPressed: () => Navigator.of(context).pop()
          ),
          new TextButton(
            child: new Text('SELESAI',
            style: TextStyle(
              color: Colors.green
            )),
            onPressed: () {
              _removeTodoItem(index);
              Navigator.of(context).pop();
            }
          )
        ]
      );
    }
  );
}

Widget _buildTodoList() {
  return new ListView.builder(
    shrinkWrap: false,
    // ignore: missing_return
    itemBuilder: (context, index) {
      if(index < _todoItems.length) {
        return _buildTodoItem(_todoItems[index], index);
      }
    },
  );
}

Widget _buildTodoItem(String todoText, int index) {
  return new ListTile(
    title: new Text(todoText),
    onTap: () => _promptRemoveTodoItem(index)
  );
}
}

