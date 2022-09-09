import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
   RxList<DragAndDropList> _contents = <DragAndDropList>[].obs;
   HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _contents.value = List.generate(10, (index) {
      return DragAndDropList(
        header: Text('Header $index'),
        children: <DragAndDropItem>[
          DragAndDropItem(
            child: Text('$index.1'),
          ),
          DragAndDropItem(
            child: Text('$index.2'),
          ),
          DragAndDropItem(
            child: Text('$index.3'),
          ),
        ],
      );
    });
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Drag Into List'),
      ),

      body: Column(
        children: <Widget>[
          Flexible(
            flex: 10,
            child: DragAndDropLists(
              children: _contents,
              onItemReorder: _onItemReorder,
              onListReorder: _onListReorder,
              onItemAdd: _onItemAdd,
              onListAdd: _onListAdd,
              listGhost: const SizedBox(
                height: 50,
                width: 100,
                child: Center(
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.pink,
                    child: Center(
                      child: Draggable<DragAndDropListInterface>(
                        feedback: const Icon(Icons.assignment),
                        data: DragAndDropList(
                          header: const Text(
                            'New default list',
                          ),
                          children: <DragAndDropItem>[],
                        ),
                        child: const Icon(Icons.assignment),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.orange,
                    child: Center(
                      child: Draggable<DragAndDropItem>(
                        feedback: const Icon(Icons.photo),
                        data: DragAndDropItem(child: const Text('New default item')),
                        child: const Icon(Icons.photo),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {

      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
  }
  _onListReorder(int oldListIndex, int newListIndex) {

      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);

  }
  _onItemAdd(DragAndDropItem newItem, int listIndex, int itemIndex) {
      if (itemIndex == -1) {
        _contents[listIndex].children.add(newItem);
      } else {
        _contents[listIndex].children.insert(itemIndex, newItem);
      }

  }
  _onListAdd(DragAndDropListInterface newList, int listIndex) {

      if (listIndex == -1) {
        _contents.add(newList as DragAndDropList);
      } else {
        _contents.insert(listIndex, newList as DragAndDropList);
      }

  }
  }

