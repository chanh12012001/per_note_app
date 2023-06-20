import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:per_note/models/account_model.dart';
import 'package:per_note/screens/widgets/storage_manage/account/account_card.dart';

class AccountList extends StatefulWidget {
  final List<Account> accounts;

  const AccountList({
    Key? key,
    required this.accounts,
  }) : super(key: key);

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: widget.accounts.length,
        itemBuilder: (context, index) {
          Account account = widget.accounts[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {},
                  child: AccountCard(
                    account: account,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
