// class Notices {
//   List<Notice> data;

//   Notices({
//     required this.data,
//   });

//   factory Notices.fromJson(Map<String, dynamic> json) => Notices(
//         data: List<Notice>.from(json["data"].map((x) => Notice.fromMap(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toMap())),
//       };
// }

// class Notice {
//   final int? nid;
//   final String? title;
//   final String? type;
//   final String? description;
//   final String? summary;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final List<FormData>? formData;
//   final String? sendEmailTo;

//   Notice({
//     required this.nid,
//     required this.title,
//     required this.type,
//     required this.description,
//     required this.summary,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.formData,
//     required this.sendEmailTo,
//   });

//   factory Notice.fromMap(map) => Notice(
//         nid: map['nid'] ?? 0,
//         title: map['title'],
//         type: map['type'],
//         description: map['description'],
//         summary: map['summary'],
//         createdAt: map['createdAt'] != null
//             ? DateTime.parse(map['createdAt'])
//             : DateTime.now(),
//         updatedAt: map['updatedAt'] != null
//             ? DateTime.parse(map['updatedAt'])
//             : DateTime.now(),
//         formData: List<FormData>.from(
//             map["form_data"].map((x) => FormData.fromMap(x))),
//         sendEmailTo: map['sendEmailTo'],
//       );

//   Map<String, dynamic> toMap() {
//     return {
//       "nid": nid,
//       "title": title,
//       "type": type,
//       "description": description,
//       "summary": summary,
//       "createdAt": createdAt,
//       "updatedAt": updatedAt,
//       "form_data": List<dynamic>.from(formData!.map((x) => x.toMap())),
//       "sendEmailTo": sendEmailTo,
//     };
//   }
// }

// class FormData {
//   final String type;
//   final bool? required;
//   final String label;
//   final String? className;
//   final String name;
//   final bool access;
//   final String? subtype;
//   final bool? toggle;
//   final bool? inline;
//   final bool? other;
//   final List<Value>? values;
//   final bool? multiple;
//   final String? style;

//   FormData({
//     required this.type,
//     this.required,
//     required this.label,
//     this.className,
//     required this.name,
//     required this.access,
//     this.subtype,
//     this.toggle,
//     this.inline,
//     this.other,
//     this.values,
//     this.multiple,
//     this.style,
//   });

//   factory FormData.fromMap(Map<String, dynamic> json) => FormData(
//         type: json["type"],
//         required: json["required"],
//         label: json["label"],
//         className: json["className"],
//         name: json["name"],
//         access: json["access"],
//         subtype: json["subtype"],
//         toggle: json["toggle"],
//         inline: json["inline"],
//         other: json["other"],
//         values: json["values"] == null
//             ? []
//             : List<Value>.from(json["values"]!.map((x) => Value.fromMap(x))),
//         multiple: json["multiple"],
//         style: json["style"],
//       );

//   Map<String, dynamic> toMap() => {
//         "type": type,
//         "required": required,
//         "label": label,
//         "className": className,
//         "name": name,
//         "access": access,
//         "subtype": subtype,
//         "toggle": toggle,
//         "inline": inline,
//         "other": other,
//         "values": values == null
//             ? []
//             : List<dynamic>.from(values!.map((x) => x.toMap())),
//         "multiple": multiple,
//         "style": style,
//       };
// }

// class Value {
//   final String label;
//   final String value;
//   final bool selected;

//   Value({
//     required this.label,
//     required this.value,
//     required this.selected,
//   });

//   factory Value.fromMap(Map<String, dynamic> json) => Value(
//         label: json["label"],
//         value: json["value"],
//         selected: json["selected"],
//       );

//   Map<String, dynamic> toMap() => {
//         "label": label,
//         "value": value,
//         "selected": selected,
//       };
// }

class Notices {
  Notices({
    required this.data,
  });

  final List<Notice> data;

  factory Notices.fromJson(Map<String, dynamic> json) {
    return Notices(
      data: json["data"] == null
          ? []
          : List<Notice>.from(json["data"]!.map((x) => Notice.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Notice {
  final int? id;
  final String? title;
  final String? type;
  final String? description;
  final String? summary;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<FormData> formdata;
  final String? sendEmailTo;
  Notice({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.summary,
    required this.createdAt,
    required this.updatedAt,
    required this.formdata,
    required this.sendEmailTo,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json["id"],
      title: json["title"],
      type: json["type"],
      description: json["description"],
      summary: json["summary"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      formdata: json["form_data"] == null
          ? []
          : List<FormData>.from(
              json["form_data"]!.map((x) => FormData.fromJson(x))),
      sendEmailTo: json["send_email_to"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "description": description,
        "summary": summary,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "form_data": formdata.map((x) => x.toJson()).toList(),
        "send_email_to": sendEmailTo,
      };
}

class FormData {
  final String? type;
  final bool? required;
  final String? label;
  final String? className;
  final String? name;
  final bool? access;
  final String? subtype;
  final bool? toggle;
  final bool? inline;
  final bool? other;
  final List<Value> values;
  final bool? multiple;
  final String? style;
  final String? value;
  FormData(
      {required this.type,
      required this.required,
      required this.label,
      required this.className,
      required this.name,
      required this.access,
      required this.subtype,
      required this.toggle,
      required this.inline,
      required this.other,
      required this.values,
      required this.multiple,
      required this.style,
      required this.value});

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      type: json["type"],
      required: json["required"],
      label: json["label"],
      className: json["className"],
      name: json["name"],
      access: json["access"],
      subtype: json["subtype"],
      toggle: json["toggle"],
      inline: json["inline"],
      other: json["other"],
      values: json["values"] == null
          ? []
          : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
      multiple: json["multiple"],
      style: json["style"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "required": required,
        "label": label,
        "className": className,
        "name": name,
        "access": access,
        "subtype": subtype,
        "toggle": toggle,
        "inline": inline,
        "other": other,
        "values": values.map((x) => x.toJson()).toList(),
        "multiple": multiple,
        "style": style,
        "value": value,
      };
}

class Value {
  final String? label;
  final String? value;
  final bool? selected;
  Value({
    required this.label,
    required this.value,
    required this.selected,
  });

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(
      label: json["label"],
      value: json["value"],
      selected: json["selected"],
    );
  }

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
        "selected": selected,
      };
}
