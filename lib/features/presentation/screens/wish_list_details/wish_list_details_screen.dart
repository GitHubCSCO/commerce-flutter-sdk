import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list_details/wish_list_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListDetailsScreen extends StatelessWidget {
  final String wishListId;

  const WishListDetailsScreen({
    super.key,
    required this.wishListId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<WishListDetailsCubit>()..loadWishListDetails(wishListId),
      child: const WishListDetailsPage(),
    );
  }
}

class WishListDetailsPage extends StatelessWidget {
  const WishListDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish List Details'),
      ),
      body: BlocBuilder<WishListDetailsCubit, WishListDetailsState>(
        builder: (context, state) {
          if (state.status == WishListStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == WishListStatus.failure) {
            return const Center(
              child: Text('Failed to load wish list details'),
            );
          } else {
            return ListView(
              children: [
                ListTile(
                  title: Text(state.wishList.name ?? ''),
                  subtitle: Text(state.wishList.description ?? ''),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.wishListLines.wishListLines?.length ?? 0,
                  itemBuilder: (context, index) {
                    final line = state.wishListLines.wishListLines?[index];
                    return ListTile(
                      title: Text(line?.productName ?? line?.altText ?? ''),
                      subtitle: Text(line?.qtyOnHand?.toString() ?? ''),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
