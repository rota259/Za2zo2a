import '../../../../../core/network/repository_base.dart';

/// Document verification status returned by the backend.
enum VerificationStatus {
  notUploaded,
  pending,
  approved,
  rejected;

  static VerificationStatus fromString(String? value) {
    switch (value?.toLowerCase().replaceAll('-', '_')) {
      case 'pending':
        return VerificationStatus.pending;
      case 'approved':
        return VerificationStatus.approved;
      case 'rejected':
        return VerificationStatus.rejected;
      default:
        return VerificationStatus.notUploaded;
    }
  }

  String get apiValue {
    switch (this) {
      case VerificationStatus.notUploaded:
        return 'not_uploaded';
      case VerificationStatus.pending:
        return 'pending';
      case VerificationStatus.approved:
        return 'approved';
      case VerificationStatus.rejected:
        return 'rejected';
    }
  }
}

/// Known document types in the verification section.
enum VerificationDocumentType {
  profilePhoto,
  driverLicense,
  nationalId,
  vehicleLicense,
  criminalRecord;

  static VerificationDocumentType? fromApiKey(String? key) {
    switch (key?.toLowerCase()) {
      case 'profile_photo':
      case 'profilephoto':
        return VerificationDocumentType.profilePhoto;
      case 'driver_license':
      case 'driverlicense':
        return VerificationDocumentType.driverLicense;
      case 'national_id':
      case 'nationalid':
        return VerificationDocumentType.nationalId;
      case 'vehicle_license':
      case 'vehiclelicense':
        return VerificationDocumentType.vehicleLicense;
      case 'criminal_record':
      case 'criminalrecord':
        return VerificationDocumentType.criminalRecord;
      default:
        return null;
    }
  }

  String get apiKey {
    switch (this) {
      case VerificationDocumentType.profilePhoto:
        return 'profile_photo';
      case VerificationDocumentType.driverLicense:
        return 'driver_license';
      case VerificationDocumentType.nationalId:
        return 'national_id';
      case VerificationDocumentType.vehicleLicense:
        return 'vehicle_license';
      case VerificationDocumentType.criminalRecord:
        return 'criminal_record';
    }
  }

  String get label {
    switch (this) {
      case VerificationDocumentType.profilePhoto:
        return 'Profile Photo';
      case VerificationDocumentType.driverLicense:
        return 'Driver License';
      case VerificationDocumentType.nationalId:
        return 'National ID';
      case VerificationDocumentType.vehicleLicense:
        return 'Vehicle License';
      case VerificationDocumentType.criminalRecord:
        return 'Criminal Record';
    }
  }
}

/// A single verification document item.
class VerificationItemModel {
  final VerificationDocumentType type;
  final VerificationStatus status;
  final String? fileUrl;
  final String? uploadedAt;
  final String? rejectionReason;

  const VerificationItemModel({
    required this.type,
    required this.status,
    this.fileUrl,
    this.uploadedAt,
    this.rejectionReason,
  });

  /// Profile photo shows a check when any file has been uploaded.
  bool get showsCheckForProfilePhoto =>
      type == VerificationDocumentType.profilePhoto &&
      status != VerificationStatus.notUploaded;

  /// Other documents show a check only when approved.
  bool get showsCheck =>
      type == VerificationDocumentType.profilePhoto
          ? showsCheckForProfilePhoto
          : status == VerificationStatus.approved;

  bool get isPending => status == VerificationStatus.pending;

  factory VerificationItemModel.fromJson(
    VerificationDocumentType type,
    Map<String, dynamic> json,
  ) {
    return VerificationItemModel(
      type: type,
      status: VerificationStatus.fromString(
        json.str(['status', 'verificationStatus', 'state']),
      ),
      fileUrl: json.str(['fileUrl', 'file_url', 'url']),
      uploadedAt: json.str(['uploadedAt', 'uploaded_at', 'updatedAt']),
      rejectionReason: json.str(['rejectionReason', 'rejection_reason']),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type.apiKey,
        'status': status.apiValue,
        if (fileUrl != null) 'file_url': fileUrl,
        if (uploadedAt != null) 'uploaded_at': uploadedAt,
        if (rejectionReason != null) 'rejection_reason': rejectionReason,
      };

  VerificationItemModel copyWith({
    VerificationStatus? status,
    String? fileUrl,
    String? uploadedAt,
    String? rejectionReason,
  }) {
    return VerificationItemModel(
      type: type,
      status: status ?? this.status,
      fileUrl: fileUrl ?? this.fileUrl,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }
}

/// Aggregate verification state for the driver profile.
class VerificationModel {
  final List<VerificationItemModel> items;

  const VerificationModel({required this.items});

  static const requiredTypes = VerificationDocumentType.values;

  factory VerificationModel.fromJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      return VerificationModel.empty();
    }

    final docsMap =
        json.mapField(['documents', 'items', 'verification']) ?? json;
    final parsed = <VerificationDocumentType, VerificationItemModel>{};

    for (final entry in docsMap.entries) {
        final type = VerificationDocumentType.fromApiKey(entry.key.toString());
        if (type == null) continue;
        final itemJson = entry.value is Map<String, dynamic>
            ? entry.value as Map<String, dynamic>
            : {'status': entry.value?.toString()};
        parsed[type] = VerificationItemModel.fromJson(type, itemJson);
    }

    final listField = json.pick(['documents', 'items']);
    if (listField is List) {
      for (final raw in listField) {
        if (raw is! Map) continue;
        final map = Map<String, dynamic>.from(raw);
        final type = VerificationDocumentType.fromApiKey(
          map.str(['type', 'documentType', 'document_type']),
        );
        if (type == null) continue;
        parsed[type] = VerificationItemModel.fromJson(type, map);
      }
    }

    final items = requiredTypes
        .map(
          (type) =>
              parsed[type] ??
              VerificationItemModel(
                type: type,
                status: VerificationStatus.notUploaded,
              ),
        )
        .toList();

    return VerificationModel(items: items);
  }

  factory VerificationModel.empty() {
    return VerificationModel(
      items: requiredTypes
          .map(
            (type) => VerificationItemModel(
              type: type,
              status: VerificationStatus.notUploaded,
            ),
          )
          .toList(),
    );
  }

  VerificationItemModel itemFor(VerificationDocumentType type) =>
      items.firstWhere((i) => i.type == type);

  int get uploadedCount =>
      items.where((i) => i.status != VerificationStatus.notUploaded).length;

  /// Overall profile verification label for the header badge.
  String get overallStatusLabel {
    if (items.every((i) => i.status == VerificationStatus.approved)) {
      return 'Verified';
    }
    if (items.any((i) => i.status == VerificationStatus.pending)) {
      return 'Pending Review';
    }
    if (items.any((i) => i.status == VerificationStatus.rejected)) {
      return 'Action Required';
    }
    return 'Incomplete';
  }

  Map<String, dynamic> toJson() => {
        'documents': {
          for (final item in items) item.type.apiKey: item.toJson(),
        },
      };
}
