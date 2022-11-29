class NotesData {
  String? _nId;
  String? _nTitle;
  String? _nContent;
  String? _notesUser;
  String? _notesimage;


  NotesData(
      {String? nId, String? nTitle, String? nContent, String? notesUser , String ? nimage}) {
    if (nId != null) {
      this._nId = nId;
    }
    if (nTitle != null) {
      this._nTitle = nTitle;
    }
    if (nContent != null) {
      this._nContent = nContent;
    }
    if (notesUser != null) {
      this._notesUser = notesUser;
    }
    if (notesUser != null) {
      this._notesimage = nimage;
    }
  }

  String? get nId => _nId;
  set nId(String? nId) => _nId = nId;
  String? get nTitle => _nTitle;
  set nTitle(String? nTitle) => _nTitle = nTitle;
  String? get nContent => _nContent;
  set nContent(String? nContent) => _nContent = nContent;
  String? get notesUser => _notesUser;
  set notesUser(String? notesUser) => _notesUser = notesUser;
  String? get notesimage => _notesimage;
  set notesimage(String? notesimage) => _notesimage = notesimage;

  NotesData.fromJson(Map<String, dynamic> json) {
    _nId = json['n_id'];
    _nTitle = json['n_title'];
    _nContent = json['n_content'];
    _notesUser = json['notes_user'];
    _notesimage = json['n_image'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['n_id'] = this._nId;
  //   data['n_title'] = this._nTitle;
  //   data['n_content'] = this._nContent;
  //   data['notes_user'] = this._notesUser;
  //   return data;
  // }
}
