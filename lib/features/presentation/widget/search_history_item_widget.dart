import 'package:flutter/material.dart';

class SearchHistoryItemWidget extends StatelessWidget {
  final String history;

  const SearchHistoryItemWidget({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 36,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: double.infinity,
            child: SizedBox(
              width: 20,
              height: 20,
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     image: NetworkImage(
              //         "https://images.unsplash.com/photo-1611451444023-7fe9d86fe1d0?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cG9ydHJhaXQlMjB3b21hbnxlbnwwfHwwfHx8MA%3D%3D"),
              //     fit: BoxFit.fill,
              //   ),
              // ),
              child: Icon(
                Icons.search,
                color: Colors.black54,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            child: Text(
              history,
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

}