import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FormData {
  List<FormComponent> components = [FormComponent()];

  void addComponent() {
    components.add(FormComponent());
  }

  void removeComponent(int index) {
    if (components.length > 1) {
      components.removeAt(index);
    }
  }
}

class FormComponent {
  String label = '';
  String infoText = '';
  String settings = 'Required';
}
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formData = GetIt.I<FormData>();

  void _updateComponent(int index, FormComponent updatedComponent) {
    setState(() {
      formData.components[index] = updatedComponent;
    });
  }

  void _removeComponent(int index) {
    setState(() {
      formData.removeComponent(index);
    });
  }

  void _addComponent() {
    setState(() {
      formData.addComponent();
    });
  }

  void _submitForm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Form Data'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: formData.components.map((component) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Label: ${component.label}'),
                      Text('Info-Text: ${component.infoText}'),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Form'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _submitForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: formData.components.length,
                itemBuilder: (context, index) {
                  return FormComponentWidget(
                    index: index,
                    component: formData.components[index],
                    onRemove: () => _removeComponent(index),
                    onChanged: (updatedComponent) => _updateComponent(index, updatedComponent),
                  );
                },
              ),
            ),
      Center(
        child: ElevatedButton(
          onPressed: _addComponent,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
            padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            ),
            elevation: 5, // Shadow elevation
          ),
          child: Text(
            'ADD',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),),
      )
          ],
        ),
      ),
    );
  }
}


class FormComponentWidget extends StatefulWidget {
  final int index;
  final FormComponent component;
  final VoidCallback onRemove;
  final ValueChanged<FormComponent> onChanged;

  FormComponentWidget({
    required this.index,
    required this.component,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  _FormComponentWidgetState createState() => _FormComponentWidgetState();
}

class _FormComponentWidgetState extends State<FormComponentWidget> {
  bool isChecked = false;
  bool isRequiredChecked = false;
  bool isReadOnlyChecked = false;
  bool isHidenOnlyChecked = false;


  void _onDonePressed() {
    setState(() {
      isChecked = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          // Keeping it static
                        },
                        activeColor: isChecked ? Colors.green : null,
                      ),
                      Text('Yes'),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: widget.onRemove,
                        child: Text(
                          'Remove',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: _onDonePressed,
                        child: Text(
                          'Done',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: widget.component.label,
                decoration: InputDecoration(
                  labelText: 'Label',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  widget.component.label = value;
                  widget.onChanged(widget.component);
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: widget.component.infoText,
                decoration: InputDecoration(
                  labelText: 'Info-Text',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  widget.component.infoText = value;
                  widget.onChanged(widget.component);
                },
              ),
              SizedBox(height: 15),
              Text('Setting'),
              Row(
                children: [
                  Checkbox(
                    value: isRequiredChecked,
                    onChanged: (value) {
                      setState(() {
                        isRequiredChecked = value!;
                      });
                    },
                  ),
                  Text('Required'),
                  Checkbox(
                    value: isReadOnlyChecked,
                    onChanged: (value) {
                      setState(() {
                        isReadOnlyChecked = value!;
                      });
                    },
                  ),
                  Text('Read Only'),
                  Checkbox(
                    value: isHidenOnlyChecked,
                    onChanged: (value) {
                      setState(() {
                        isHidenOnlyChecked = value!;
                      });
                    },
                  ),
                  Text('Hidden Files'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

