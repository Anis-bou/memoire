import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/models/comment.dart';
import 'package:blogapp/screens/agence/login.dart';
import 'package:blogapp/services/agence_service.dart';
import 'package:blogapp/services/comment_service.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentScreen extends StatefulWidget {
  final int? postId;

  CommentScreen({this.postId});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<dynamic> _commentsList = [];
  bool _loading = true;
  int userId = 0;
  int _editCommentId = 0;
  TextEditingController _txtCommentController = TextEditingController();
  TextEditingController _txtnameController = TextEditingController();
  // Get comments

  Future<void> _getComments() async {
    userId = await Api.getAgenceId();
    ApiResponse response = await getComments(widget.postId ?? 0);

    if (response.error == null) {
      setState(() {
        _commentsList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  // create comment
  void _createComment() async {
    ApiResponse response = await createComment(widget.postId ?? 0,
        _txtCommentController.text, _txtnameController.text);

    if (response.error == null) {
      _txtCommentController.clear();
      _getComments();
    } else if (response.error == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    } else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  // Delete comment
  void _deleteComment(int commentId) async {
    ApiResponse response = await deleteComment(commentId);

    if (response.error == null) {
      _getComments();
    } else if (response.error == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    _getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: C_3,
        title: Text(AppLocalizations.of(context)!.comment),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              Expanded(
                  child: RefreshIndicator(
                      onRefresh: () {
                        return _getComments();
                      },
                      child: ListView.builder(
                          itemCount: _commentsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Comment comment = _commentsList[index];
                            return Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black26, width: 0.5))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          PopupMenuButton(
                                            child: const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.more_vert,
                                                  color: Colors.black,
                                                )),
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                  child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .delete),
                                                  value: AppLocalizations.of(
                                                          context)!
                                                      .delete)
                                            ],
                                            onSelected: (val) {
                                              _deleteComment(comment.id ?? 0);
                                            },
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${comment.name}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('${comment.comment}')
                                ],
                              ),
                            );
                          }))),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.black26, width: 0.5)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: kInputDecoration(
                            AppLocalizations.of(context)!.add_your_name,
                            Icons.person),
                        controller: _txtnameController,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      color: C_3,
                      onPressed: () {
                        if (_txtCommentController.text.isNotEmpty) {
                          setState(() {
                            _loading = true;
                          });

                          _createComment();
                        }
                      },
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.black26, width: 0.5)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: kInputDecoration(
                            AppLocalizations.of(context)!.add_your_comment,
                            Icons.short_text_outlined),
                        controller: _txtCommentController,
                      ),
                    ),
                  ],
                ),
              )
            ]),
    );
  }
}
