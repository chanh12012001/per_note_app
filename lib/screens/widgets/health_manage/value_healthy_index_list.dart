import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:per_note/models/detail_healthy_index_model.dart';
import 'package:per_note/models/healthy_index_model.dart';
import 'package:per_note/services/toast_service.dart';
import 'package:provider/provider.dart';

import '../../../providers/detail_healthy_index_provider.dart';
import '../../../providers/loading_provider.dart';
import '../alert_dialog.dart';

class ValueHealthyIndexList extends StatefulWidget {
  final HealthyIndex healthyIndex;
  final List<DetailHealthyIndex> detailDealthyIndexList;
  const ValueHealthyIndexList({
    Key? key,
    required this.detailDealthyIndexList,
    required this.healthyIndex,
  }) : super(key: key);

  @override
  State<ValueHealthyIndexList> createState() => _ValueHealthyIndexListState();
}

class _ValueHealthyIndexListState extends State<ValueHealthyIndexList> {
  ToastService toast = ToastService();
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailHealthyIndexProvider>(
        builder: (context, detailHealthyIndexProvider, child) {
      return ListView.builder(
        itemCount: widget.detailDealthyIndexList.length,
        itemBuilder: ((context, index) {
          DetailHealthyIndex detailHealthyIndex =
              widget.detailDealthyIndexList[index];
          return Card(
            child: ListTile(
              leading: Container(
                width: 55,
                height: 55,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).primaryColor.withAlpha(50),
                ),
                child: Image.network(
                  widget.healthyIndex.iconUrl!,
                  width: 60,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_forever),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return MyAlertDialog(
                        title: 'Warning !!!',
                        subTitle: 'Bạn có chắc chắn muốn xoá ?',
                        action: () {
                          _deleteDetailHealthyIndex(detailHealthyIndex);
                        },
                      );
                    },
                  );
                },
              ),
              title: Text(
                "${detailHealthyIndex.indexValue!} ${widget.healthyIndex.unit}",
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              subtitle: Text(
                  '${detailHealthyIndex.createAtTime} - ${detailHealthyIndex.createAtDate}'),
            ),
          );
        }),
      );
    });
  }

  _deleteDetailHealthyIndex(DetailHealthyIndex detailHealthyIndex) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    DetailHealthyIndexProvider detailHealthyIndexProvider =
        Provider.of<DetailHealthyIndexProvider>(context, listen: false);
    detailHealthyIndexProvider
        .deleteDetailHealthyIndex(detailHealthyIndex)
        .then(
      (response) {
        if (response['status']) {
          Navigator.pop(context);
          loadingProvider.setLoading(false);
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.green,
          );
        } else {
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.redAccent,
          );
        }
      },
    );
  }
}
