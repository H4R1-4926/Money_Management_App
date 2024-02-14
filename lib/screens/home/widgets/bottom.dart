import 'package:flutter/material.dart';
import 'package:money_management/screens/home/homescreen.dart';

class Btmnav extends StatelessWidget {
  const Btmnav({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Homescreen.selectedindexnotifier,
      builder: (ctx, updatedindex, _) {
        return BottomNavigationBar(
          currentIndex: updatedindex,
          onTap: (newIndex) {
            Homescreen.selectedindexnotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'transaction'),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Catogory',
            ),
          ],
        );
      },
    );
  }
}
