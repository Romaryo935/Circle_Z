
import 'package:circle_z/model/item.dart';
import 'package:circle_z/pages/details_screen.dart';
import 'package:flutter/material.dart';


class ItemTravel extends StatelessWidget {
  final String title, img;
  const ItemTravel({Key? key, required this.title, required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) =>   Details(product: items[1]))
          ),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/$img'))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          color: Colors.grey, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        'Location of place',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 19, 172, 134),
                      shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {},
                      icon:
                          const Icon(Icons.add, color: Colors.white, size: 30)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
