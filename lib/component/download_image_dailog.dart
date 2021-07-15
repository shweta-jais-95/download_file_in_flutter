import 'dart:io' show Directory, Platform;
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:file_downlaod_in_flutter/utility/enum.dart';
import 'package:file_downlaod_in_flutter/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DownloadDialogLayout extends StatefulWidget {
  final String url;
  final String fileName;
  final Map<String, String>? headers;

  DownloadDialogLayout(
      {required this.url, required this.fileName, required this.headers});

  @override
  _DownloadDialogLayoutState createState() => _DownloadDialogLayoutState();
}

class _DownloadDialogLayoutState extends State<DownloadDialogLayout> {
  int progress = 0;
  String savedPath = "";
  DownloadState downloadStage = DownloadState.Started;
  late BuildContext scaffoldContext;

  @override
  void initState() {
    downloadFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scaffoldContext = context;
    List<Widget> list = [];
    list.add(
      Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: Row(
          children: <Widget>[
            downloadStage == DownloadState.Started
                ? Container(
                    margin: EdgeInsets.only(right: 16),
                    child: CircularProgressIndicator())
                : Container(),
            downloadStage == DownloadState.Started
                ? Text(
                    "${Strings.downloading}  $progress%",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  )
                : Text(
                    downloadStage == DownloadState.Failed
                        ? Strings.downloadFailed
                        : Strings.downloadedSuccessfully,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
    if (downloadStage == DownloadState.Success) {
      list.add(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                Strings.close.toUpperCase(),
                style: TextStyle(color: Colors.blue, fontSize: 13),
              )),
          TextButton(
              onPressed: () {
                _openFileFromLocalStorage();
              },
              child: Text(
                Strings.view.toUpperCase(),
                style: TextStyle(color: Colors.blue, fontSize: 13),
              )),
        ],
      ));
    }
    return SimpleDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text("${widget.fileName}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
              downloadStage == DownloadState.Failed
                  ? InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        children: list);
  }

  _showSnackBar() {
    final ScaffoldMessengerState scaffoldMessenger =
        ScaffoldMessenger.of(scaffoldContext);
    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text(Strings.failedToOpen)),
    );
  }

  _openFileFromLocalStorage() async {
    Navigator.pop(context);
    try {
      final _result = await OpenFile.open(savedPath);
      if (_result.type == ResultType.done) {
      } else {
        _showSnackBar();
      }
    } catch (e) {
      _showSnackBar();
    }
  }

  Future<void> downloadFile() async {
    downloadStage = DownloadState.Started;
    savedPath = await getFilePath(widget.fileName);
    Dio dio = Dio();
    try {
      widget.headers != null
          ? await dio.download(
              widget.url,
              savedPath,
              options: Options(headers: widget.headers),
              onReceiveProgress: (rcv, total) {
                if (mounted) {
                  setState(() {
                    progress = ((rcv / total) * 100).toInt();
                    if (progress == 100) {
                      downloadStage = DownloadState.Success;
                    }
                  });
                }
              },
              deleteOnError: true,
            )
          : await dio.download(
              widget.url,
              savedPath,
              onReceiveProgress: (rcv, total) {
                if (mounted) {
                  setState(() {
                    progress = ((rcv / total) * 100).toInt();
                    if (progress == 100) {
                      downloadStage = DownloadState.Success;
                    }
                  });
                }
              },
              deleteOnError: true,
            );
    } catch (e) {
      print(e);
      downloadStage = DownloadState.Failed;
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<String> getFilePath(fileName) async {
    String path = '';
    try {
      Directory? appDocDir = Platform.isAndroid
          ? (await getExternalStorageDirectory())
          : (await getApplicationDocumentsDirectory());
      String uniqueFileName =
          '${DateFormat('MM-dd-hh-mm-ss').format(DateTime.now())}-$fileName';
      path = '${appDocDir?.path}/$uniqueFileName';
    } catch (e) {
      print(e);
      downloadStage = DownloadState.Failed;
    }
    return path;
  }
}
