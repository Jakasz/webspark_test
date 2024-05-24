class PathData {
  bool? error;
  String? message;
  List<Data>? data;

  PathData({this.error, this.message, this.data});

  PathData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  List<String>? field;
  Start? start;
  End? end;

  Data({this.id, this.field, this.start, this.end});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    field = json['field'].cast<String>();
    start = json['start'] != null ? Start.fromJson(json['start']) : null;
    end = json['end'] != null ? End.fromJson(json['end']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['field'] = field;
    if (start != null) {
      data['start'] = start!.toJson();
    }
    if (end != null) {
      data['end'] = end!.toJson();
    }
    return data;
  }
}

class Start {
  int? x;
  int? y;

  Start({this.x, this.y});

  Start.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x'] = x;
    data['y'] = y;
    return data;
  }
}

class End {
  int? x;
  int? y;

  End({this.x, this.y});

  End.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x'] = x;
    data['y'] = y;
    return data;
  }
}
