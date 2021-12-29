import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_logindesgin/modles/shop_app/Favorites_model.dart';
import 'package:flutter_application_logindesgin/moduels/shop_app/Cubit/cubit.dart';
import 'package:flutter_application_logindesgin/moduels/shop_app/Cubit/stats.dart';
import 'package:flutter_application_logindesgin/shared/shared.component/component.dart';
// import 'package:flutter_application_logindesgin/moduels/shop_app/Cubit/cubit.dart';
import 'package:flutter_application_logindesgin/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(
        listener: (context, state) {},
        builder: (context, state) {
          // return ShopCubit.get(context).favoritesModel.data.data.length != 0
          //     ? ListView.separated(
          //         itemBuilder: (context, index) => buildFavItem(
          //             ShopCubit.get(context).favoritesModel.data.data[index],
          //             context),
          //         separatorBuilder: (context, index) => MuDivder(),
          //         itemCount:
          //             ShopCubit.get(context).favoritesModel.data.data.length)
          //     : null;
          return ConditionalBuilder(
            condition: state is ShopLoadingGetFavoritesState,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildFavItem(
                    ShopCubit.get(context).favoritesModel.data.data[index],
                    context),
                separatorBuilder: (context, index) => MuDivder(),
                itemCount:
                    ShopCubit.get(context).favoritesModel.data.data.length),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildFavItem(FavoritesData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.product.image),
                    width: 120,
                    height: 120,
                  ),
                  if (model.product.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.product.price.toString(),
                          style: TextStyle(
                              fontSize: 12, height: 1.3, color: deflaultColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (model.product.discount != 0)
                          Text(
                            model.product.oldPrice.toString(),
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product.id);
                          },
                          icon: CircleAvatar(
                            backgroundColor: ShopCubit.get(context)
                                    .favorites[model.product.id]
                                ? deflaultColor
                                : Colors.grey,
                            radius: 15,
                            child: Icon(
                              Icons.favorite_border,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
