import 'dart:convert';

MessageDetails messageDetailsFromJson(String str) =>
    MessageDetails.fromJson(json.decode(str));

String messageDetailsToJson(MessageDetails data) => json.encode(data.toJson());

class MessageDetails {
  MessageDetails({
    required this.context,
    required this.id,
    required this.type,
    required this.messageDetailsId,
    required this.accountId,
    required this.msgid,
    required this.from,
    required this.to,
    required this.cc,
    required this.bcc,
    required this.subject,
    required this.seen,
    required this.flagged,
    required this.isDeleted,
    required this.verifications,
    required this.retention,
    required this.retentionDate,
    required this.text,
    required this.html,
    required this.hasAttachments,
    required this.attachments,
    required this.size,
    required this.downloadUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final String context;
  final String id;
  final String type;
  final String messageDetailsId;
  final String accountId;
  final String msgid;
  final From from;
  final List<From> to;
  final List<String> cc;
  final List<String> bcc;
  final String subject;
  final bool seen;
  final bool flagged;
  final bool isDeleted;
  final List<String> verifications;
  final bool retention;
  final DateTime retentionDate;
  final String text;
  final List<String> html;
  final bool hasAttachments;
  final List<Attachment> attachments;
  final int size;
  final String downloadUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory MessageDetails.fromJson(Map<String, dynamic> json) => MessageDetails(
        context: json["@context"],
        id: json["@id"],
        type: json["@type"],
        messageDetailsId: json["id"],
        accountId: json["accountId"],
        msgid: json["msgid"],
        from: From.fromJson(json["from"]),
        to: List<From>.from(json["to"].map((x) => From.fromJson(x))),
        cc: List<String>.from(json["cc"].map((x) => x)),
        bcc: List<String>.from(json["bcc"].map((x) => x)),
        subject: json["subject"],
        seen: json["seen"],
        flagged: json["flagged"],
        isDeleted: json["isDeleted"],
        verifications: List<String>.from(json["verifications"].map((x) => x)),
        retention: json["retention"],
        retentionDate: DateTime.parse(json["retentionDate"]),
        text: json["text"],
        html: List<String>.from(json["html"].map((x) => x)),
        hasAttachments: json["hasAttachments"],
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
        size: json["size"],
        downloadUrl: json["downloadUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "@context": context,
        "@id": id,
        "@type": type,
        "id": messageDetailsId,
        "accountId": accountId,
        "msgid": msgid,
        "from": from.toJson(),
        "to": List<dynamic>.from(to.map((x) => x.toJson())),
        "cc": List<dynamic>.from(cc.map((x) => x)),
        "bcc": List<dynamic>.from(bcc.map((x) => x)),
        "subject": subject,
        "seen": seen,
        "flagged": flagged,
        "isDeleted": isDeleted,
        "verifications": List<dynamic>.from(verifications.map((x) => x)),
        "retention": retention,
        "retentionDate": retentionDate.toIso8601String(),
        "text": text,
        "html": List<dynamic>.from(html.map((x) => x)),
        "hasAttachments": hasAttachments,
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "size": size,
        "downloadUrl": downloadUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Attachment {
  Attachment({
    required this.id,
    required this.filename,
    required this.contentType,
    required this.disposition,
    required this.transferEncoding,
    required this.related,
    required this.size,
    required this.downloadUrl,
  });

  final String id;
  final String filename;
  final String contentType;
  final String disposition;
  final String transferEncoding;
  final bool related;
  final int size;
  final String downloadUrl;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        filename: json["filename"],
        contentType: json["contentType"],
        disposition: json["disposition"],
        transferEncoding: json["transferEncoding"],
        related: json["related"],
        size: json["size"],
        downloadUrl: json["downloadUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "contentType": contentType,
        "disposition": disposition,
        "transferEncoding": transferEncoding,
        "related": related,
        "size": size,
        "downloadUrl": downloadUrl,
      };
}

class From {
  From({
    required this.name,
    required this.address,
  });

  final String name;
  final String address;

  factory From.fromJson(Map<String, dynamic> json) => From(
        name: json["name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
      };
}
