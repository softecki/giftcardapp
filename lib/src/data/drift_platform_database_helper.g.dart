// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_platform_database_helper.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _identificationNumberMeta =
      const VerificationMeta('identificationNumber');
  @override
  late final GeneratedColumn<String> identificationNumber =
      GeneratedColumn<String>('identification_number', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _otpMeta = const VerificationMeta('otp');
  @override
  late final GeneratedColumn<String> otp = GeneratedColumn<String>(
      'otp', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _otpVerifiedMeta =
      const VerificationMeta('otpVerified');
  @override
  late final GeneratedColumn<String> otpVerified = GeneratedColumn<String>(
      'otp_verified', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _changePasswordMeta =
      const VerificationMeta('changePassword');
  @override
  late final GeneratedColumn<String> changePassword = GeneratedColumn<String>(
      'change_password', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _commissionChargeMeta =
      const VerificationMeta('commissionCharge');
  @override
  late final GeneratedColumn<String> commissionCharge = GeneratedColumn<String>(
      'commission_charge', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _admissionChargeMeta =
      const VerificationMeta('admissionCharge');
  @override
  late final GeneratedColumn<String> admissionCharge = GeneratedColumn<String>(
      'admission_charge', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _qrLinkMeta = const VerificationMeta('qrLink');
  @override
  late final GeneratedColumn<String> qrLink = GeneratedColumn<String>(
      'qr_link', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('1234567890'));
  static const VerificationMeta _merchantNumberMeta =
      const VerificationMeta('merchantNumber');
  @override
  late final GeneratedColumn<String> merchantNumber = GeneratedColumn<String>(
      'merchant_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        phone,
        identificationNumber,
        email,
        username,
        password,
        status,
        otp,
        otpVerified,
        createdAt,
        updatedAt,
        changePassword,
        commissionCharge,
        admissionCharge,
        qrLink,
        merchantNumber
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('identification_number')) {
      context.handle(
          _identificationNumberMeta,
          identificationNumber.isAcceptableOrUnknown(
              data['identification_number']!, _identificationNumberMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('otp')) {
      context.handle(
          _otpMeta, otp.isAcceptableOrUnknown(data['otp']!, _otpMeta));
    }
    if (data.containsKey('otp_verified')) {
      context.handle(
          _otpVerifiedMeta,
          otpVerified.isAcceptableOrUnknown(
              data['otp_verified']!, _otpVerifiedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('change_password')) {
      context.handle(
          _changePasswordMeta,
          changePassword.isAcceptableOrUnknown(
              data['change_password']!, _changePasswordMeta));
    }
    if (data.containsKey('commission_charge')) {
      context.handle(
          _commissionChargeMeta,
          commissionCharge.isAcceptableOrUnknown(
              data['commission_charge']!, _commissionChargeMeta));
    }
    if (data.containsKey('admission_charge')) {
      context.handle(
          _admissionChargeMeta,
          admissionCharge.isAcceptableOrUnknown(
              data['admission_charge']!, _admissionChargeMeta));
    }
    if (data.containsKey('qr_link')) {
      context.handle(_qrLinkMeta,
          qrLink.isAcceptableOrUnknown(data['qr_link']!, _qrLinkMeta));
    }
    if (data.containsKey('merchant_number')) {
      context.handle(
          _merchantNumberMeta,
          merchantNumber.isAcceptableOrUnknown(
              data['merchant_number']!, _merchantNumberMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      identificationNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}identification_number']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      otp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}otp']),
      otpVerified: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}otp_verified']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at']),
      changePassword: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}change_password']),
      commissionCharge: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}commission_charge']),
      admissionCharge: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}admission_charge']),
      qrLink: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}qr_link'])!,
      merchantNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}merchant_number']),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String? name;
  final String? phone;
  final String? identificationNumber;
  final String? email;
  final String? username;
  final String? password;
  final String? status;
  final String? otp;
  final String? otpVerified;
  final String? createdAt;
  final String? updatedAt;
  final String? changePassword;
  final String? commissionCharge;
  final String? admissionCharge;
  final String qrLink;
  final String? merchantNumber;
  const User(
      {required this.id,
      this.name,
      this.phone,
      this.identificationNumber,
      this.email,
      this.username,
      this.password,
      this.status,
      this.otp,
      this.otpVerified,
      this.createdAt,
      this.updatedAt,
      this.changePassword,
      this.commissionCharge,
      this.admissionCharge,
      required this.qrLink,
      this.merchantNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || identificationNumber != null) {
      map['identification_number'] = Variable<String>(identificationNumber);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || otp != null) {
      map['otp'] = Variable<String>(otp);
    }
    if (!nullToAbsent || otpVerified != null) {
      map['otp_verified'] = Variable<String>(otpVerified);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    if (!nullToAbsent || changePassword != null) {
      map['change_password'] = Variable<String>(changePassword);
    }
    if (!nullToAbsent || commissionCharge != null) {
      map['commission_charge'] = Variable<String>(commissionCharge);
    }
    if (!nullToAbsent || admissionCharge != null) {
      map['admission_charge'] = Variable<String>(admissionCharge);
    }
    map['qr_link'] = Variable<String>(qrLink);
    if (!nullToAbsent || merchantNumber != null) {
      map['merchant_number'] = Variable<String>(merchantNumber);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      identificationNumber: identificationNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(identificationNumber),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      otp: otp == null && nullToAbsent ? const Value.absent() : Value(otp),
      otpVerified: otpVerified == null && nullToAbsent
          ? const Value.absent()
          : Value(otpVerified),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      changePassword: changePassword == null && nullToAbsent
          ? const Value.absent()
          : Value(changePassword),
      commissionCharge: commissionCharge == null && nullToAbsent
          ? const Value.absent()
          : Value(commissionCharge),
      admissionCharge: admissionCharge == null && nullToAbsent
          ? const Value.absent()
          : Value(admissionCharge),
      qrLink: Value(qrLink),
      merchantNumber: merchantNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantNumber),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      identificationNumber:
          serializer.fromJson<String?>(json['identificationNumber']),
      email: serializer.fromJson<String?>(json['email']),
      username: serializer.fromJson<String?>(json['username']),
      password: serializer.fromJson<String?>(json['password']),
      status: serializer.fromJson<String?>(json['status']),
      otp: serializer.fromJson<String?>(json['otp']),
      otpVerified: serializer.fromJson<String?>(json['otpVerified']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
      changePassword: serializer.fromJson<String?>(json['changePassword']),
      commissionCharge: serializer.fromJson<String?>(json['commissionCharge']),
      admissionCharge: serializer.fromJson<String?>(json['admissionCharge']),
      qrLink: serializer.fromJson<String>(json['qrLink']),
      merchantNumber: serializer.fromJson<String?>(json['merchantNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'phone': serializer.toJson<String?>(phone),
      'identificationNumber': serializer.toJson<String?>(identificationNumber),
      'email': serializer.toJson<String?>(email),
      'username': serializer.toJson<String?>(username),
      'password': serializer.toJson<String?>(password),
      'status': serializer.toJson<String?>(status),
      'otp': serializer.toJson<String?>(otp),
      'otpVerified': serializer.toJson<String?>(otpVerified),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
      'changePassword': serializer.toJson<String?>(changePassword),
      'commissionCharge': serializer.toJson<String?>(commissionCharge),
      'admissionCharge': serializer.toJson<String?>(admissionCharge),
      'qrLink': serializer.toJson<String>(qrLink),
      'merchantNumber': serializer.toJson<String?>(merchantNumber),
    };
  }

  User copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> identificationNumber = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> username = const Value.absent(),
          Value<String?> password = const Value.absent(),
          Value<String?> status = const Value.absent(),
          Value<String?> otp = const Value.absent(),
          Value<String?> otpVerified = const Value.absent(),
          Value<String?> createdAt = const Value.absent(),
          Value<String?> updatedAt = const Value.absent(),
          Value<String?> changePassword = const Value.absent(),
          Value<String?> commissionCharge = const Value.absent(),
          Value<String?> admissionCharge = const Value.absent(),
          String? qrLink,
          Value<String?> merchantNumber = const Value.absent()}) =>
      User(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        phone: phone.present ? phone.value : this.phone,
        identificationNumber: identificationNumber.present
            ? identificationNumber.value
            : this.identificationNumber,
        email: email.present ? email.value : this.email,
        username: username.present ? username.value : this.username,
        password: password.present ? password.value : this.password,
        status: status.present ? status.value : this.status,
        otp: otp.present ? otp.value : this.otp,
        otpVerified: otpVerified.present ? otpVerified.value : this.otpVerified,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        changePassword:
            changePassword.present ? changePassword.value : this.changePassword,
        commissionCharge: commissionCharge.present
            ? commissionCharge.value
            : this.commissionCharge,
        admissionCharge: admissionCharge.present
            ? admissionCharge.value
            : this.admissionCharge,
        qrLink: qrLink ?? this.qrLink,
        merchantNumber:
            merchantNumber.present ? merchantNumber.value : this.merchantNumber,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      identificationNumber: data.identificationNumber.present
          ? data.identificationNumber.value
          : this.identificationNumber,
      email: data.email.present ? data.email.value : this.email,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      status: data.status.present ? data.status.value : this.status,
      otp: data.otp.present ? data.otp.value : this.otp,
      otpVerified:
          data.otpVerified.present ? data.otpVerified.value : this.otpVerified,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      changePassword: data.changePassword.present
          ? data.changePassword.value
          : this.changePassword,
      commissionCharge: data.commissionCharge.present
          ? data.commissionCharge.value
          : this.commissionCharge,
      admissionCharge: data.admissionCharge.present
          ? data.admissionCharge.value
          : this.admissionCharge,
      qrLink: data.qrLink.present ? data.qrLink.value : this.qrLink,
      merchantNumber: data.merchantNumber.present
          ? data.merchantNumber.value
          : this.merchantNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('identificationNumber: $identificationNumber, ')
          ..write('email: $email, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('status: $status, ')
          ..write('otp: $otp, ')
          ..write('otpVerified: $otpVerified, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('changePassword: $changePassword, ')
          ..write('commissionCharge: $commissionCharge, ')
          ..write('admissionCharge: $admissionCharge, ')
          ..write('qrLink: $qrLink, ')
          ..write('merchantNumber: $merchantNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      phone,
      identificationNumber,
      email,
      username,
      password,
      status,
      otp,
      otpVerified,
      createdAt,
      updatedAt,
      changePassword,
      commissionCharge,
      admissionCharge,
      qrLink,
      merchantNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.identificationNumber == this.identificationNumber &&
          other.email == this.email &&
          other.username == this.username &&
          other.password == this.password &&
          other.status == this.status &&
          other.otp == this.otp &&
          other.otpVerified == this.otpVerified &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.changePassword == this.changePassword &&
          other.commissionCharge == this.commissionCharge &&
          other.admissionCharge == this.admissionCharge &&
          other.qrLink == this.qrLink &&
          other.merchantNumber == this.merchantNumber);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String?> phone;
  final Value<String?> identificationNumber;
  final Value<String?> email;
  final Value<String?> username;
  final Value<String?> password;
  final Value<String?> status;
  final Value<String?> otp;
  final Value<String?> otpVerified;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<String?> changePassword;
  final Value<String?> commissionCharge;
  final Value<String?> admissionCharge;
  final Value<String> qrLink;
  final Value<String?> merchantNumber;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.identificationNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.status = const Value.absent(),
    this.otp = const Value.absent(),
    this.otpVerified = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.changePassword = const Value.absent(),
    this.commissionCharge = const Value.absent(),
    this.admissionCharge = const Value.absent(),
    this.qrLink = const Value.absent(),
    this.merchantNumber = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.identificationNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.status = const Value.absent(),
    this.otp = const Value.absent(),
    this.otpVerified = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.changePassword = const Value.absent(),
    this.commissionCharge = const Value.absent(),
    this.admissionCharge = const Value.absent(),
    this.qrLink = const Value.absent(),
    this.merchantNumber = const Value.absent(),
  });
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? identificationNumber,
    Expression<String>? email,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? status,
    Expression<String>? otp,
    Expression<String>? otpVerified,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? changePassword,
    Expression<String>? commissionCharge,
    Expression<String>? admissionCharge,
    Expression<String>? qrLink,
    Expression<String>? merchantNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (identificationNumber != null)
        'identification_number': identificationNumber,
      if (email != null) 'email': email,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (status != null) 'status': status,
      if (otp != null) 'otp': otp,
      if (otpVerified != null) 'otp_verified': otpVerified,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (changePassword != null) 'change_password': changePassword,
      if (commissionCharge != null) 'commission_charge': commissionCharge,
      if (admissionCharge != null) 'admission_charge': admissionCharge,
      if (qrLink != null) 'qr_link': qrLink,
      if (merchantNumber != null) 'merchant_number': merchantNumber,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<String?>? phone,
      Value<String?>? identificationNumber,
      Value<String?>? email,
      Value<String?>? username,
      Value<String?>? password,
      Value<String?>? status,
      Value<String?>? otp,
      Value<String?>? otpVerified,
      Value<String?>? createdAt,
      Value<String?>? updatedAt,
      Value<String?>? changePassword,
      Value<String?>? commissionCharge,
      Value<String?>? admissionCharge,
      Value<String>? qrLink,
      Value<String?>? merchantNumber}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      identificationNumber: identificationNumber ?? this.identificationNumber,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      otp: otp ?? this.otp,
      otpVerified: otpVerified ?? this.otpVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      changePassword: changePassword ?? this.changePassword,
      commissionCharge: commissionCharge ?? this.commissionCharge,
      admissionCharge: admissionCharge ?? this.admissionCharge,
      qrLink: qrLink ?? this.qrLink,
      merchantNumber: merchantNumber ?? this.merchantNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (identificationNumber.present) {
      map['identification_number'] =
          Variable<String>(identificationNumber.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (otp.present) {
      map['otp'] = Variable<String>(otp.value);
    }
    if (otpVerified.present) {
      map['otp_verified'] = Variable<String>(otpVerified.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (changePassword.present) {
      map['change_password'] = Variable<String>(changePassword.value);
    }
    if (commissionCharge.present) {
      map['commission_charge'] = Variable<String>(commissionCharge.value);
    }
    if (admissionCharge.present) {
      map['admission_charge'] = Variable<String>(admissionCharge.value);
    }
    if (qrLink.present) {
      map['qr_link'] = Variable<String>(qrLink.value);
    }
    if (merchantNumber.present) {
      map['merchant_number'] = Variable<String>(merchantNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('identificationNumber: $identificationNumber, ')
          ..write('email: $email, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('status: $status, ')
          ..write('otp: $otp, ')
          ..write('otpVerified: $otpVerified, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('changePassword: $changePassword, ')
          ..write('commissionCharge: $commissionCharge, ')
          ..write('admissionCharge: $admissionCharge, ')
          ..write('qrLink: $qrLink, ')
          ..write('merchantNumber: $merchantNumber')
          ..write(')'))
        .toString();
  }
}

class $MerchantsTable extends Merchants
    with TableInfo<$MerchantsTable, Merchant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MerchantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _mechantCodeMeta =
      const VerificationMeta('mechantCode');
  @override
  late final GeneratedColumn<String> mechantCode = GeneratedColumn<String>(
      'mechant_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _identificationNumberMeta =
      const VerificationMeta('identificationNumber');
  @override
  late final GeneratedColumn<String> identificationNumber =
      GeneratedColumn<String>('identification_number', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _licenceNumberMeta =
      const VerificationMeta('licenceNumber');
  @override
  late final GeneratedColumn<String> licenceNumber = GeneratedColumn<String>(
      'licence_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _documentReferenceIdMeta =
      const VerificationMeta('documentReferenceId');
  @override
  late final GeneratedColumn<String> documentReferenceId =
      GeneratedColumn<String>('document_refence_id', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('1'));
  static const VerificationMeta _agentIdMeta =
      const VerificationMeta('agentId');
  @override
  late final GeneratedColumn<int> agentId = GeneratedColumn<int>(
      'agent_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _otpMeta = const VerificationMeta('otp');
  @override
  late final GeneratedColumn<String> otp = GeneratedColumn<String>(
      'otp', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _commentsMeta =
      const VerificationMeta('comments');
  @override
  late final GeneratedColumn<String> comments = GeneratedColumn<String>(
      'comments', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _otpVerifiedMeta =
      const VerificationMeta('otpVerified');
  @override
  late final GeneratedColumn<String> otpVerified = GeneratedColumn<String>(
      'otp_verified', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tinMeta = const VerificationMeta('tin');
  @override
  late final GeneratedColumn<String> tin = GeneratedColumn<String>(
      'tin', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _changePasswordMeta =
      const VerificationMeta('changePassword');
  @override
  late final GeneratedColumn<String> changePassword = GeneratedColumn<String>(
      'change_password', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _qrLinkMeta = const VerificationMeta('qrLink');
  @override
  late final GeneratedColumn<String> qrLink = GeneratedColumn<String>(
      'qr_link', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('1234567890'));
  static const VerificationMeta _merchantNumberMeta =
      const VerificationMeta('merchantNumber');
  @override
  late final GeneratedColumn<String> merchantNumber = GeneratedColumn<String>(
      'merchant_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        mechantCode,
        name,
        phone,
        password,
        email,
        identificationNumber,
        licenceNumber,
        documentReferenceId,
        status,
        agentId,
        userId,
        createdAt,
        updatedAt,
        otp,
        comments,
        otpVerified,
        tin,
        changePassword,
        qrLink,
        merchantNumber
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'merchants';
  @override
  VerificationContext validateIntegrity(Insertable<Merchant> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mechant_code')) {
      context.handle(
          _mechantCodeMeta,
          mechantCode.isAcceptableOrUnknown(
              data['mechant_code']!, _mechantCodeMeta));
    } else if (isInserting) {
      context.missing(_mechantCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('identification_number')) {
      context.handle(
          _identificationNumberMeta,
          identificationNumber.isAcceptableOrUnknown(
              data['identification_number']!, _identificationNumberMeta));
    } else if (isInserting) {
      context.missing(_identificationNumberMeta);
    }
    if (data.containsKey('licence_number')) {
      context.handle(
          _licenceNumberMeta,
          licenceNumber.isAcceptableOrUnknown(
              data['licence_number']!, _licenceNumberMeta));
    }
    if (data.containsKey('document_refence_id')) {
      context.handle(
          _documentReferenceIdMeta,
          documentReferenceId.isAcceptableOrUnknown(
              data['document_refence_id']!, _documentReferenceIdMeta));
    } else if (isInserting) {
      context.missing(_documentReferenceIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('agent_id')) {
      context.handle(_agentIdMeta,
          agentId.isAcceptableOrUnknown(data['agent_id']!, _agentIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('otp')) {
      context.handle(
          _otpMeta, otp.isAcceptableOrUnknown(data['otp']!, _otpMeta));
    }
    if (data.containsKey('comments')) {
      context.handle(_commentsMeta,
          comments.isAcceptableOrUnknown(data['comments']!, _commentsMeta));
    }
    if (data.containsKey('otp_verified')) {
      context.handle(
          _otpVerifiedMeta,
          otpVerified.isAcceptableOrUnknown(
              data['otp_verified']!, _otpVerifiedMeta));
    }
    if (data.containsKey('tin')) {
      context.handle(
          _tinMeta, tin.isAcceptableOrUnknown(data['tin']!, _tinMeta));
    }
    if (data.containsKey('change_password')) {
      context.handle(
          _changePasswordMeta,
          changePassword.isAcceptableOrUnknown(
              data['change_password']!, _changePasswordMeta));
    }
    if (data.containsKey('qr_link')) {
      context.handle(_qrLinkMeta,
          qrLink.isAcceptableOrUnknown(data['qr_link']!, _qrLinkMeta));
    }
    if (data.containsKey('merchant_number')) {
      context.handle(
          _merchantNumberMeta,
          merchantNumber.isAcceptableOrUnknown(
              data['merchant_number']!, _merchantNumberMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Merchant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Merchant(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      mechantCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mechant_code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      identificationNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}identification_number'])!,
      licenceNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}licence_number']),
      documentReferenceId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}document_refence_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      agentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}agent_id']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at']),
      otp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}otp']),
      comments: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comments']),
      otpVerified: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}otp_verified']),
      tin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tin']),
      changePassword: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}change_password']),
      qrLink: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}qr_link'])!,
      merchantNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}merchant_number']),
    );
  }

  @override
  $MerchantsTable createAlias(String alias) {
    return $MerchantsTable(attachedDatabase, alias);
  }
}

class Merchant extends DataClass implements Insertable<Merchant> {
  final int id;
  final String mechantCode;
  final String name;
  final String phone;
  final String password;
  final String? email;
  final String identificationNumber;
  final String? licenceNumber;
  final String documentReferenceId;
  final String status;
  final int? agentId;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final String? otp;
  final String? comments;
  final String? otpVerified;
  final String? tin;
  final String? changePassword;
  final String qrLink;
  final String? merchantNumber;
  const Merchant(
      {required this.id,
      required this.mechantCode,
      required this.name,
      required this.phone,
      required this.password,
      this.email,
      required this.identificationNumber,
      this.licenceNumber,
      required this.documentReferenceId,
      required this.status,
      this.agentId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.otp,
      this.comments,
      this.otpVerified,
      this.tin,
      this.changePassword,
      required this.qrLink,
      this.merchantNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mechant_code'] = Variable<String>(mechantCode);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    map['password'] = Variable<String>(password);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['identification_number'] = Variable<String>(identificationNumber);
    if (!nullToAbsent || licenceNumber != null) {
      map['licence_number'] = Variable<String>(licenceNumber);
    }
    map['document_refence_id'] = Variable<String>(documentReferenceId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || agentId != null) {
      map['agent_id'] = Variable<int>(agentId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    if (!nullToAbsent || otp != null) {
      map['otp'] = Variable<String>(otp);
    }
    if (!nullToAbsent || comments != null) {
      map['comments'] = Variable<String>(comments);
    }
    if (!nullToAbsent || otpVerified != null) {
      map['otp_verified'] = Variable<String>(otpVerified);
    }
    if (!nullToAbsent || tin != null) {
      map['tin'] = Variable<String>(tin);
    }
    if (!nullToAbsent || changePassword != null) {
      map['change_password'] = Variable<String>(changePassword);
    }
    map['qr_link'] = Variable<String>(qrLink);
    if (!nullToAbsent || merchantNumber != null) {
      map['merchant_number'] = Variable<String>(merchantNumber);
    }
    return map;
  }

  MerchantsCompanion toCompanion(bool nullToAbsent) {
    return MerchantsCompanion(
      id: Value(id),
      mechantCode: Value(mechantCode),
      name: Value(name),
      phone: Value(phone),
      password: Value(password),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      identificationNumber: Value(identificationNumber),
      licenceNumber: licenceNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(licenceNumber),
      documentReferenceId: Value(documentReferenceId),
      status: Value(status),
      agentId: agentId == null && nullToAbsent
          ? const Value.absent()
          : Value(agentId),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      otp: otp == null && nullToAbsent ? const Value.absent() : Value(otp),
      comments: comments == null && nullToAbsent
          ? const Value.absent()
          : Value(comments),
      otpVerified: otpVerified == null && nullToAbsent
          ? const Value.absent()
          : Value(otpVerified),
      tin: tin == null && nullToAbsent ? const Value.absent() : Value(tin),
      changePassword: changePassword == null && nullToAbsent
          ? const Value.absent()
          : Value(changePassword),
      qrLink: Value(qrLink),
      merchantNumber: merchantNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantNumber),
    );
  }

  factory Merchant.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Merchant(
      id: serializer.fromJson<int>(json['id']),
      mechantCode: serializer.fromJson<String>(json['mechantCode']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      password: serializer.fromJson<String>(json['password']),
      email: serializer.fromJson<String?>(json['email']),
      identificationNumber:
          serializer.fromJson<String>(json['identificationNumber']),
      licenceNumber: serializer.fromJson<String?>(json['licenceNumber']),
      documentReferenceId:
          serializer.fromJson<String>(json['documentReferenceId']),
      status: serializer.fromJson<String>(json['status']),
      agentId: serializer.fromJson<int?>(json['agentId']),
      userId: serializer.fromJson<int?>(json['userId']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
      otp: serializer.fromJson<String?>(json['otp']),
      comments: serializer.fromJson<String?>(json['comments']),
      otpVerified: serializer.fromJson<String?>(json['otpVerified']),
      tin: serializer.fromJson<String?>(json['tin']),
      changePassword: serializer.fromJson<String?>(json['changePassword']),
      qrLink: serializer.fromJson<String>(json['qrLink']),
      merchantNumber: serializer.fromJson<String?>(json['merchantNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mechantCode': serializer.toJson<String>(mechantCode),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'password': serializer.toJson<String>(password),
      'email': serializer.toJson<String?>(email),
      'identificationNumber': serializer.toJson<String>(identificationNumber),
      'licenceNumber': serializer.toJson<String?>(licenceNumber),
      'documentReferenceId': serializer.toJson<String>(documentReferenceId),
      'status': serializer.toJson<String>(status),
      'agentId': serializer.toJson<int?>(agentId),
      'userId': serializer.toJson<int?>(userId),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
      'otp': serializer.toJson<String?>(otp),
      'comments': serializer.toJson<String?>(comments),
      'otpVerified': serializer.toJson<String?>(otpVerified),
      'tin': serializer.toJson<String?>(tin),
      'changePassword': serializer.toJson<String?>(changePassword),
      'qrLink': serializer.toJson<String>(qrLink),
      'merchantNumber': serializer.toJson<String?>(merchantNumber),
    };
  }

  Merchant copyWith(
          {int? id,
          String? mechantCode,
          String? name,
          String? phone,
          String? password,
          Value<String?> email = const Value.absent(),
          String? identificationNumber,
          Value<String?> licenceNumber = const Value.absent(),
          String? documentReferenceId,
          String? status,
          Value<int?> agentId = const Value.absent(),
          Value<int?> userId = const Value.absent(),
          Value<String?> createdAt = const Value.absent(),
          Value<String?> updatedAt = const Value.absent(),
          Value<String?> otp = const Value.absent(),
          Value<String?> comments = const Value.absent(),
          Value<String?> otpVerified = const Value.absent(),
          Value<String?> tin = const Value.absent(),
          Value<String?> changePassword = const Value.absent(),
          String? qrLink,
          Value<String?> merchantNumber = const Value.absent()}) =>
      Merchant(
        id: id ?? this.id,
        mechantCode: mechantCode ?? this.mechantCode,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        email: email.present ? email.value : this.email,
        identificationNumber: identificationNumber ?? this.identificationNumber,
        licenceNumber:
            licenceNumber.present ? licenceNumber.value : this.licenceNumber,
        documentReferenceId: documentReferenceId ?? this.documentReferenceId,
        status: status ?? this.status,
        agentId: agentId.present ? agentId.value : this.agentId,
        userId: userId.present ? userId.value : this.userId,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        otp: otp.present ? otp.value : this.otp,
        comments: comments.present ? comments.value : this.comments,
        otpVerified: otpVerified.present ? otpVerified.value : this.otpVerified,
        tin: tin.present ? tin.value : this.tin,
        changePassword:
            changePassword.present ? changePassword.value : this.changePassword,
        qrLink: qrLink ?? this.qrLink,
        merchantNumber:
            merchantNumber.present ? merchantNumber.value : this.merchantNumber,
      );
  Merchant copyWithCompanion(MerchantsCompanion data) {
    return Merchant(
      id: data.id.present ? data.id.value : this.id,
      mechantCode:
          data.mechantCode.present ? data.mechantCode.value : this.mechantCode,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      password: data.password.present ? data.password.value : this.password,
      email: data.email.present ? data.email.value : this.email,
      identificationNumber: data.identificationNumber.present
          ? data.identificationNumber.value
          : this.identificationNumber,
      licenceNumber: data.licenceNumber.present
          ? data.licenceNumber.value
          : this.licenceNumber,
      documentReferenceId: data.documentReferenceId.present
          ? data.documentReferenceId.value
          : this.documentReferenceId,
      status: data.status.present ? data.status.value : this.status,
      agentId: data.agentId.present ? data.agentId.value : this.agentId,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      otp: data.otp.present ? data.otp.value : this.otp,
      comments: data.comments.present ? data.comments.value : this.comments,
      otpVerified:
          data.otpVerified.present ? data.otpVerified.value : this.otpVerified,
      tin: data.tin.present ? data.tin.value : this.tin,
      changePassword: data.changePassword.present
          ? data.changePassword.value
          : this.changePassword,
      qrLink: data.qrLink.present ? data.qrLink.value : this.qrLink,
      merchantNumber: data.merchantNumber.present
          ? data.merchantNumber.value
          : this.merchantNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Merchant(')
          ..write('id: $id, ')
          ..write('mechantCode: $mechantCode, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('password: $password, ')
          ..write('email: $email, ')
          ..write('identificationNumber: $identificationNumber, ')
          ..write('licenceNumber: $licenceNumber, ')
          ..write('documentReferenceId: $documentReferenceId, ')
          ..write('status: $status, ')
          ..write('agentId: $agentId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('otp: $otp, ')
          ..write('comments: $comments, ')
          ..write('otpVerified: $otpVerified, ')
          ..write('tin: $tin, ')
          ..write('changePassword: $changePassword, ')
          ..write('qrLink: $qrLink, ')
          ..write('merchantNumber: $merchantNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        mechantCode,
        name,
        phone,
        password,
        email,
        identificationNumber,
        licenceNumber,
        documentReferenceId,
        status,
        agentId,
        userId,
        createdAt,
        updatedAt,
        otp,
        comments,
        otpVerified,
        tin,
        changePassword,
        qrLink,
        merchantNumber
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Merchant &&
          other.id == this.id &&
          other.mechantCode == this.mechantCode &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.password == this.password &&
          other.email == this.email &&
          other.identificationNumber == this.identificationNumber &&
          other.licenceNumber == this.licenceNumber &&
          other.documentReferenceId == this.documentReferenceId &&
          other.status == this.status &&
          other.agentId == this.agentId &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.otp == this.otp &&
          other.comments == this.comments &&
          other.otpVerified == this.otpVerified &&
          other.tin == this.tin &&
          other.changePassword == this.changePassword &&
          other.qrLink == this.qrLink &&
          other.merchantNumber == this.merchantNumber);
}

class MerchantsCompanion extends UpdateCompanion<Merchant> {
  final Value<int> id;
  final Value<String> mechantCode;
  final Value<String> name;
  final Value<String> phone;
  final Value<String> password;
  final Value<String?> email;
  final Value<String> identificationNumber;
  final Value<String?> licenceNumber;
  final Value<String> documentReferenceId;
  final Value<String> status;
  final Value<int?> agentId;
  final Value<int?> userId;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<String?> otp;
  final Value<String?> comments;
  final Value<String?> otpVerified;
  final Value<String?> tin;
  final Value<String?> changePassword;
  final Value<String> qrLink;
  final Value<String?> merchantNumber;
  const MerchantsCompanion({
    this.id = const Value.absent(),
    this.mechantCode = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.password = const Value.absent(),
    this.email = const Value.absent(),
    this.identificationNumber = const Value.absent(),
    this.licenceNumber = const Value.absent(),
    this.documentReferenceId = const Value.absent(),
    this.status = const Value.absent(),
    this.agentId = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.otp = const Value.absent(),
    this.comments = const Value.absent(),
    this.otpVerified = const Value.absent(),
    this.tin = const Value.absent(),
    this.changePassword = const Value.absent(),
    this.qrLink = const Value.absent(),
    this.merchantNumber = const Value.absent(),
  });
  MerchantsCompanion.insert({
    this.id = const Value.absent(),
    required String mechantCode,
    required String name,
    required String phone,
    required String password,
    this.email = const Value.absent(),
    required String identificationNumber,
    this.licenceNumber = const Value.absent(),
    required String documentReferenceId,
    this.status = const Value.absent(),
    this.agentId = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.otp = const Value.absent(),
    this.comments = const Value.absent(),
    this.otpVerified = const Value.absent(),
    this.tin = const Value.absent(),
    this.changePassword = const Value.absent(),
    this.qrLink = const Value.absent(),
    this.merchantNumber = const Value.absent(),
  })  : mechantCode = Value(mechantCode),
        name = Value(name),
        phone = Value(phone),
        password = Value(password),
        identificationNumber = Value(identificationNumber),
        documentReferenceId = Value(documentReferenceId);
  static Insertable<Merchant> custom({
    Expression<int>? id,
    Expression<String>? mechantCode,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? password,
    Expression<String>? email,
    Expression<String>? identificationNumber,
    Expression<String>? licenceNumber,
    Expression<String>? documentReferenceId,
    Expression<String>? status,
    Expression<int>? agentId,
    Expression<int>? userId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? otp,
    Expression<String>? comments,
    Expression<String>? otpVerified,
    Expression<String>? tin,
    Expression<String>? changePassword,
    Expression<String>? qrLink,
    Expression<String>? merchantNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mechantCode != null) 'mechant_code': mechantCode,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (password != null) 'password': password,
      if (email != null) 'email': email,
      if (identificationNumber != null)
        'identification_number': identificationNumber,
      if (licenceNumber != null) 'licence_number': licenceNumber,
      if (documentReferenceId != null)
        'document_refence_id': documentReferenceId,
      if (status != null) 'status': status,
      if (agentId != null) 'agent_id': agentId,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (otp != null) 'otp': otp,
      if (comments != null) 'comments': comments,
      if (otpVerified != null) 'otp_verified': otpVerified,
      if (tin != null) 'tin': tin,
      if (changePassword != null) 'change_password': changePassword,
      if (qrLink != null) 'qr_link': qrLink,
      if (merchantNumber != null) 'merchant_number': merchantNumber,
    });
  }

  MerchantsCompanion copyWith(
      {Value<int>? id,
      Value<String>? mechantCode,
      Value<String>? name,
      Value<String>? phone,
      Value<String>? password,
      Value<String?>? email,
      Value<String>? identificationNumber,
      Value<String?>? licenceNumber,
      Value<String>? documentReferenceId,
      Value<String>? status,
      Value<int?>? agentId,
      Value<int?>? userId,
      Value<String?>? createdAt,
      Value<String?>? updatedAt,
      Value<String?>? otp,
      Value<String?>? comments,
      Value<String?>? otpVerified,
      Value<String?>? tin,
      Value<String?>? changePassword,
      Value<String>? qrLink,
      Value<String?>? merchantNumber}) {
    return MerchantsCompanion(
      id: id ?? this.id,
      mechantCode: mechantCode ?? this.mechantCode,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      email: email ?? this.email,
      identificationNumber: identificationNumber ?? this.identificationNumber,
      licenceNumber: licenceNumber ?? this.licenceNumber,
      documentReferenceId: documentReferenceId ?? this.documentReferenceId,
      status: status ?? this.status,
      agentId: agentId ?? this.agentId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      otp: otp ?? this.otp,
      comments: comments ?? this.comments,
      otpVerified: otpVerified ?? this.otpVerified,
      tin: tin ?? this.tin,
      changePassword: changePassword ?? this.changePassword,
      qrLink: qrLink ?? this.qrLink,
      merchantNumber: merchantNumber ?? this.merchantNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mechantCode.present) {
      map['mechant_code'] = Variable<String>(mechantCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (identificationNumber.present) {
      map['identification_number'] =
          Variable<String>(identificationNumber.value);
    }
    if (licenceNumber.present) {
      map['licence_number'] = Variable<String>(licenceNumber.value);
    }
    if (documentReferenceId.present) {
      map['document_refence_id'] = Variable<String>(documentReferenceId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (agentId.present) {
      map['agent_id'] = Variable<int>(agentId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (otp.present) {
      map['otp'] = Variable<String>(otp.value);
    }
    if (comments.present) {
      map['comments'] = Variable<String>(comments.value);
    }
    if (otpVerified.present) {
      map['otp_verified'] = Variable<String>(otpVerified.value);
    }
    if (tin.present) {
      map['tin'] = Variable<String>(tin.value);
    }
    if (changePassword.present) {
      map['change_password'] = Variable<String>(changePassword.value);
    }
    if (qrLink.present) {
      map['qr_link'] = Variable<String>(qrLink.value);
    }
    if (merchantNumber.present) {
      map['merchant_number'] = Variable<String>(merchantNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MerchantsCompanion(')
          ..write('id: $id, ')
          ..write('mechantCode: $mechantCode, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('password: $password, ')
          ..write('email: $email, ')
          ..write('identificationNumber: $identificationNumber, ')
          ..write('licenceNumber: $licenceNumber, ')
          ..write('documentReferenceId: $documentReferenceId, ')
          ..write('status: $status, ')
          ..write('agentId: $agentId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('otp: $otp, ')
          ..write('comments: $comments, ')
          ..write('otpVerified: $otpVerified, ')
          ..write('tin: $tin, ')
          ..write('changePassword: $changePassword, ')
          ..write('qrLink: $qrLink, ')
          ..write('merchantNumber: $merchantNumber')
          ..write(')'))
        .toString();
  }
}

class $BalancesTable extends Balances with TableInfo<$BalancesTable, Balance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BalancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<String> amount = GeneratedColumn<String>(
      'amount', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, userId, amount, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'balances';
  @override
  VerificationContext validateIntegrity(Insertable<Balance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Balance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Balance(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}amount']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $BalancesTable createAlias(String alias) {
    return $BalancesTable(attachedDatabase, alias);
  }
}

class Balance extends DataClass implements Insertable<Balance> {
  final int id;
  final String userId;
  final String? amount;
  final DateTime date;
  const Balance(
      {required this.id,
      required this.userId,
      this.amount,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<String>(amount);
    }
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  BalancesCompanion toCompanion(bool nullToAbsent) {
    return BalancesCompanion(
      id: Value(id),
      userId: Value(userId),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      date: Value(date),
    );
  }

  factory Balance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Balance(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      amount: serializer.fromJson<String?>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'amount': serializer.toJson<String?>(amount),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Balance copyWith(
          {int? id,
          String? userId,
          Value<String?> amount = const Value.absent(),
          DateTime? date}) =>
      Balance(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        amount: amount.present ? amount.value : this.amount,
        date: date ?? this.date,
      );
  Balance copyWithCompanion(BalancesCompanion data) {
    return Balance(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Balance(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('amount: $amount, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, amount, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Balance &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.amount == this.amount &&
          other.date == this.date);
}

class BalancesCompanion extends UpdateCompanion<Balance> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String?> amount;
  final Value<DateTime> date;
  const BalancesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
  });
  BalancesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<Balance> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? amount,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
    });
  }

  BalancesCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String?>? amount,
      Value<DateTime>? date}) {
    return BalancesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<String>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BalancesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('amount: $amount, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _identificationNumberMeta =
      const VerificationMeta('identificationNumber');
  @override
  late final GeneratedColumn<String> identificationNumber =
      GeneratedColumn<String>('identification_number', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _otpMeta = const VerificationMeta('otp');
  @override
  late final GeneratedColumn<String> otp = GeneratedColumn<String>(
      'otp', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        phone,
        identificationNumber,
        email,
        username,
        password,
        status,
        createdAt,
        updatedAt,
        otp
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('identification_number')) {
      context.handle(
          _identificationNumberMeta,
          identificationNumber.isAcceptableOrUnknown(
              data['identification_number']!, _identificationNumberMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('otp')) {
      context.handle(
          _otpMeta, otp.isAcceptableOrUnknown(data['otp']!, _otpMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      identificationNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}identification_number']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at']),
      otp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}otp']),
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String? name;
  final String? phone;
  final String? identificationNumber;
  final String? email;
  final String? username;
  final String? password;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? otp;
  const Customer(
      {required this.id,
      this.name,
      this.phone,
      this.identificationNumber,
      this.email,
      this.username,
      this.password,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.otp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || identificationNumber != null) {
      map['identification_number'] = Variable<String>(identificationNumber);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    if (!nullToAbsent || otp != null) {
      map['otp'] = Variable<String>(otp);
    }
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      identificationNumber: identificationNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(identificationNumber),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      otp: otp == null && nullToAbsent ? const Value.absent() : Value(otp),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      identificationNumber:
          serializer.fromJson<String?>(json['identificationNumber']),
      email: serializer.fromJson<String?>(json['email']),
      username: serializer.fromJson<String?>(json['username']),
      password: serializer.fromJson<String?>(json['password']),
      status: serializer.fromJson<String?>(json['status']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
      otp: serializer.fromJson<String?>(json['otp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'phone': serializer.toJson<String?>(phone),
      'identificationNumber': serializer.toJson<String?>(identificationNumber),
      'email': serializer.toJson<String?>(email),
      'username': serializer.toJson<String?>(username),
      'password': serializer.toJson<String?>(password),
      'status': serializer.toJson<String?>(status),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
      'otp': serializer.toJson<String?>(otp),
    };
  }

  Customer copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> identificationNumber = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> username = const Value.absent(),
          Value<String?> password = const Value.absent(),
          Value<String?> status = const Value.absent(),
          Value<String?> createdAt = const Value.absent(),
          Value<String?> updatedAt = const Value.absent(),
          Value<String?> otp = const Value.absent()}) =>
      Customer(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        phone: phone.present ? phone.value : this.phone,
        identificationNumber: identificationNumber.present
            ? identificationNumber.value
            : this.identificationNumber,
        email: email.present ? email.value : this.email,
        username: username.present ? username.value : this.username,
        password: password.present ? password.value : this.password,
        status: status.present ? status.value : this.status,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        otp: otp.present ? otp.value : this.otp,
      );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      identificationNumber: data.identificationNumber.present
          ? data.identificationNumber.value
          : this.identificationNumber,
      email: data.email.present ? data.email.value : this.email,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      otp: data.otp.present ? data.otp.value : this.otp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('identificationNumber: $identificationNumber, ')
          ..write('email: $email, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('otp: $otp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone, identificationNumber, email,
      username, password, status, createdAt, updatedAt, otp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.identificationNumber == this.identificationNumber &&
          other.email == this.email &&
          other.username == this.username &&
          other.password == this.password &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.otp == this.otp);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String?> phone;
  final Value<String?> identificationNumber;
  final Value<String?> email;
  final Value<String?> username;
  final Value<String?> password;
  final Value<String?> status;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<String?> otp;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.identificationNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.otp = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.identificationNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.otp = const Value.absent(),
  });
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? identificationNumber,
    Expression<String>? email,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? status,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? otp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (identificationNumber != null)
        'identification_number': identificationNumber,
      if (email != null) 'email': email,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (otp != null) 'otp': otp,
    });
  }

  CustomersCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<String?>? phone,
      Value<String?>? identificationNumber,
      Value<String?>? email,
      Value<String?>? username,
      Value<String?>? password,
      Value<String?>? status,
      Value<String?>? createdAt,
      Value<String?>? updatedAt,
      Value<String?>? otp}) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      identificationNumber: identificationNumber ?? this.identificationNumber,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      otp: otp ?? this.otp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (identificationNumber.present) {
      map['identification_number'] =
          Variable<String>(identificationNumber.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (otp.present) {
      map['otp'] = Variable<String>(otp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('identificationNumber: $identificationNumber, ')
          ..write('email: $email, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('otp: $otp')
          ..write(')'))
        .toString();
  }
}

class $AccountSetupsTable extends AccountSetups
    with TableInfo<$AccountSetupsTable, AccountSetup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountSetupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _accountNumberMeta =
      const VerificationMeta('accountNumber');
  @override
  late final GeneratedColumn<String> accountNumber = GeneratedColumn<String>(
      'account_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _paymentTypeMeta =
      const VerificationMeta('paymentType');
  @override
  late final GeneratedColumn<String> paymentType = GeneratedColumn<String>(
      'payment_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _selectedBankMeta =
      const VerificationMeta('selectedBank');
  @override
  late final GeneratedColumn<String> selectedBank = GeneratedColumn<String>(
      'selected_bank', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, accountNumber, paymentType, selectedBank];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_setups';
  @override
  VerificationContext validateIntegrity(Insertable<AccountSetup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('account_number')) {
      context.handle(
          _accountNumberMeta,
          accountNumber.isAcceptableOrUnknown(
              data['account_number']!, _accountNumberMeta));
    }
    if (data.containsKey('payment_type')) {
      context.handle(
          _paymentTypeMeta,
          paymentType.isAcceptableOrUnknown(
              data['payment_type']!, _paymentTypeMeta));
    }
    if (data.containsKey('selected_bank')) {
      context.handle(
          _selectedBankMeta,
          selectedBank.isAcceptableOrUnknown(
              data['selected_bank']!, _selectedBankMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountSetup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountSetup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      accountNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_number']),
      paymentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_type']),
      selectedBank: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}selected_bank']),
    );
  }

  @override
  $AccountSetupsTable createAlias(String alias) {
    return $AccountSetupsTable(attachedDatabase, alias);
  }
}

class AccountSetup extends DataClass implements Insertable<AccountSetup> {
  final int id;
  final String? userId;
  final String? accountNumber;
  final String? paymentType;
  final String? selectedBank;
  const AccountSetup(
      {required this.id,
      this.userId,
      this.accountNumber,
      this.paymentType,
      this.selectedBank});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || accountNumber != null) {
      map['account_number'] = Variable<String>(accountNumber);
    }
    if (!nullToAbsent || paymentType != null) {
      map['payment_type'] = Variable<String>(paymentType);
    }
    if (!nullToAbsent || selectedBank != null) {
      map['selected_bank'] = Variable<String>(selectedBank);
    }
    return map;
  }

  AccountSetupsCompanion toCompanion(bool nullToAbsent) {
    return AccountSetupsCompanion(
      id: Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      accountNumber: accountNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(accountNumber),
      paymentType: paymentType == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentType),
      selectedBank: selectedBank == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedBank),
    );
  }

  factory AccountSetup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountSetup(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      accountNumber: serializer.fromJson<String?>(json['accountNumber']),
      paymentType: serializer.fromJson<String?>(json['paymentType']),
      selectedBank: serializer.fromJson<String?>(json['selectedBank']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String?>(userId),
      'accountNumber': serializer.toJson<String?>(accountNumber),
      'paymentType': serializer.toJson<String?>(paymentType),
      'selectedBank': serializer.toJson<String?>(selectedBank),
    };
  }

  AccountSetup copyWith(
          {int? id,
          Value<String?> userId = const Value.absent(),
          Value<String?> accountNumber = const Value.absent(),
          Value<String?> paymentType = const Value.absent(),
          Value<String?> selectedBank = const Value.absent()}) =>
      AccountSetup(
        id: id ?? this.id,
        userId: userId.present ? userId.value : this.userId,
        accountNumber:
            accountNumber.present ? accountNumber.value : this.accountNumber,
        paymentType: paymentType.present ? paymentType.value : this.paymentType,
        selectedBank:
            selectedBank.present ? selectedBank.value : this.selectedBank,
      );
  AccountSetup copyWithCompanion(AccountSetupsCompanion data) {
    return AccountSetup(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      accountNumber: data.accountNumber.present
          ? data.accountNumber.value
          : this.accountNumber,
      paymentType:
          data.paymentType.present ? data.paymentType.value : this.paymentType,
      selectedBank: data.selectedBank.present
          ? data.selectedBank.value
          : this.selectedBank,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountSetup(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('paymentType: $paymentType, ')
          ..write('selectedBank: $selectedBank')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, accountNumber, paymentType, selectedBank);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountSetup &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.accountNumber == this.accountNumber &&
          other.paymentType == this.paymentType &&
          other.selectedBank == this.selectedBank);
}

class AccountSetupsCompanion extends UpdateCompanion<AccountSetup> {
  final Value<int> id;
  final Value<String?> userId;
  final Value<String?> accountNumber;
  final Value<String?> paymentType;
  final Value<String?> selectedBank;
  const AccountSetupsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.selectedBank = const Value.absent(),
  });
  AccountSetupsCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.selectedBank = const Value.absent(),
  });
  static Insertable<AccountSetup> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? accountNumber,
    Expression<String>? paymentType,
    Expression<String>? selectedBank,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (accountNumber != null) 'account_number': accountNumber,
      if (paymentType != null) 'payment_type': paymentType,
      if (selectedBank != null) 'selected_bank': selectedBank,
    });
  }

  AccountSetupsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? userId,
      Value<String?>? accountNumber,
      Value<String?>? paymentType,
      Value<String?>? selectedBank}) {
    return AccountSetupsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      accountNumber: accountNumber ?? this.accountNumber,
      paymentType: paymentType ?? this.paymentType,
      selectedBank: selectedBank ?? this.selectedBank,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (accountNumber.present) {
      map['account_number'] = Variable<String>(accountNumber.value);
    }
    if (paymentType.present) {
      map['payment_type'] = Variable<String>(paymentType.value);
    }
    if (selectedBank.present) {
      map['selected_bank'] = Variable<String>(selectedBank.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountSetupsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('paymentType: $paymentType, ')
          ..write('selectedBank: $selectedBank')
          ..write(')'))
        .toString();
  }
}

class $StatusTable extends Status with TableInfo<$StatusTable, StatusData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatusTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'status';
  @override
  VerificationContext validateIntegrity(Insertable<StatusData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StatusData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StatusData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $StatusTable createAlias(String alias) {
    return $StatusTable(attachedDatabase, alias);
  }
}

class StatusData extends DataClass implements Insertable<StatusData> {
  final int id;
  final String name;
  final String? createdAt;
  final String? updatedAt;
  const StatusData(
      {required this.id, required this.name, this.createdAt, this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  StatusCompanion toCompanion(bool nullToAbsent) {
    return StatusCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory StatusData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StatusData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  StatusData copyWith(
          {int? id,
          String? name,
          Value<String?> createdAt = const Value.absent(),
          Value<String?> updatedAt = const Value.absent()}) =>
      StatusData(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  StatusData copyWithCompanion(StatusCompanion data) {
    return StatusData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StatusData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StatusData &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StatusCompanion extends UpdateCompanion<StatusData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  const StatusCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StatusCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<StatusData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StatusCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? createdAt,
      Value<String?>? updatedAt}) {
    return StatusCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatusCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<int> paymentMethod = GeneratedColumn<int>(
      'payment_method', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _paymentGatewayMeta =
      const VerificationMeta('paymentGateway');
  @override
  late final GeneratedColumn<String> paymentGateway = GeneratedColumn<String>(
      'payment_gateway', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
      'transaction_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _feesAssignChildrenIdMeta =
      const VerificationMeta('feesAssignChildrenId');
  @override
  late final GeneratedColumn<int> feesAssignChildrenId = GeneratedColumn<int>(
      'fees_assign_children_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _feesCollectByMeta =
      const VerificationMeta('feesCollectBy');
  @override
  late final GeneratedColumn<int> feesCollectBy = GeneratedColumn<int>(
      'fees_collect_by', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _studentIdMeta =
      const VerificationMeta('studentId');
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
      'student_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
      'session_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<String> amount = GeneratedColumn<String>(
      'amount', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fineAmountMeta =
      const VerificationMeta('fineAmount');
  @override
  late final GeneratedColumn<String> fineAmount = GeneratedColumn<String>(
      'fine_amount', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
      'account_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _commentsMeta =
      const VerificationMeta('comments');
  @override
  late final GeneratedColumn<String> comments = GeneratedColumn<String>(
      'comments', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _printedMeta =
      const VerificationMeta('printed');
  @override
  late final GeneratedColumn<int> printed = GeneratedColumn<int>(
      'printed', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        paymentMethod,
        paymentGateway,
        transactionId,
        feesAssignChildrenId,
        feesCollectBy,
        studentId,
        sessionId,
        amount,
        fineAmount,
        accountId,
        comments,
        printed,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    }
    if (data.containsKey('payment_gateway')) {
      context.handle(
          _paymentGatewayMeta,
          paymentGateway.isAcceptableOrUnknown(
              data['payment_gateway']!, _paymentGatewayMeta));
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    }
    if (data.containsKey('fees_assign_children_id')) {
      context.handle(
          _feesAssignChildrenIdMeta,
          feesAssignChildrenId.isAcceptableOrUnknown(
              data['fees_assign_children_id']!, _feesAssignChildrenIdMeta));
    }
    if (data.containsKey('fees_collect_by')) {
      context.handle(
          _feesCollectByMeta,
          feesCollectBy.isAcceptableOrUnknown(
              data['fees_collect_by']!, _feesCollectByMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(_studentIdMeta,
          studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    if (data.containsKey('fine_amount')) {
      context.handle(
          _fineAmountMeta,
          fineAmount.isAcceptableOrUnknown(
              data['fine_amount']!, _fineAmountMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    }
    if (data.containsKey('comments')) {
      context.handle(_commentsMeta,
          comments.isAcceptableOrUnknown(data['comments']!, _commentsMeta));
    }
    if (data.containsKey('printed')) {
      context.handle(_printedMeta,
          printed.isAcceptableOrUnknown(data['printed']!, _printedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date']),
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_method']),
      paymentGateway: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_gateway']),
      transactionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transaction_id']),
      feesAssignChildrenId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}fees_assign_children_id']),
      feesCollectBy: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fees_collect_by']),
      studentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}student_id']),
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}session_id']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}amount']),
      fineAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fine_amount']),
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account_id']),
      comments: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comments']),
      printed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}printed']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final String? date;
  final int? paymentMethod;
  final String? paymentGateway;
  final String? transactionId;
  final int? feesAssignChildrenId;
  final int? feesCollectBy;
  final int? studentId;
  final int? sessionId;
  final String? amount;
  final String? fineAmount;
  final int? accountId;
  final String? comments;
  final int? printed;
  final String? createdAt;
  final String? updatedAt;
  const Transaction(
      {required this.id,
      this.date,
      this.paymentMethod,
      this.paymentGateway,
      this.transactionId,
      this.feesAssignChildrenId,
      this.feesCollectBy,
      this.studentId,
      this.sessionId,
      this.amount,
      this.fineAmount,
      this.accountId,
      this.comments,
      this.printed,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<int>(paymentMethod);
    }
    if (!nullToAbsent || paymentGateway != null) {
      map['payment_gateway'] = Variable<String>(paymentGateway);
    }
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<String>(transactionId);
    }
    if (!nullToAbsent || feesAssignChildrenId != null) {
      map['fees_assign_children_id'] = Variable<int>(feesAssignChildrenId);
    }
    if (!nullToAbsent || feesCollectBy != null) {
      map['fees_collect_by'] = Variable<int>(feesCollectBy);
    }
    if (!nullToAbsent || studentId != null) {
      map['student_id'] = Variable<int>(studentId);
    }
    if (!nullToAbsent || sessionId != null) {
      map['session_id'] = Variable<int>(sessionId);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<String>(amount);
    }
    if (!nullToAbsent || fineAmount != null) {
      map['fine_amount'] = Variable<String>(fineAmount);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<int>(accountId);
    }
    if (!nullToAbsent || comments != null) {
      map['comments'] = Variable<String>(comments);
    }
    if (!nullToAbsent || printed != null) {
      map['printed'] = Variable<int>(printed);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      paymentGateway: paymentGateway == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentGateway),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      feesAssignChildrenId: feesAssignChildrenId == null && nullToAbsent
          ? const Value.absent()
          : Value(feesAssignChildrenId),
      feesCollectBy: feesCollectBy == null && nullToAbsent
          ? const Value.absent()
          : Value(feesCollectBy),
      studentId: studentId == null && nullToAbsent
          ? const Value.absent()
          : Value(studentId),
      sessionId: sessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionId),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      fineAmount: fineAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(fineAmount),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      comments: comments == null && nullToAbsent
          ? const Value.absent()
          : Value(comments),
      printed: printed == null && nullToAbsent
          ? const Value.absent()
          : Value(printed),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String?>(json['date']),
      paymentMethod: serializer.fromJson<int?>(json['paymentMethod']),
      paymentGateway: serializer.fromJson<String?>(json['paymentGateway']),
      transactionId: serializer.fromJson<String?>(json['transactionId']),
      feesAssignChildrenId:
          serializer.fromJson<int?>(json['feesAssignChildrenId']),
      feesCollectBy: serializer.fromJson<int?>(json['feesCollectBy']),
      studentId: serializer.fromJson<int?>(json['studentId']),
      sessionId: serializer.fromJson<int?>(json['sessionId']),
      amount: serializer.fromJson<String?>(json['amount']),
      fineAmount: serializer.fromJson<String?>(json['fineAmount']),
      accountId: serializer.fromJson<int?>(json['accountId']),
      comments: serializer.fromJson<String?>(json['comments']),
      printed: serializer.fromJson<int?>(json['printed']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String?>(date),
      'paymentMethod': serializer.toJson<int?>(paymentMethod),
      'paymentGateway': serializer.toJson<String?>(paymentGateway),
      'transactionId': serializer.toJson<String?>(transactionId),
      'feesAssignChildrenId': serializer.toJson<int?>(feesAssignChildrenId),
      'feesCollectBy': serializer.toJson<int?>(feesCollectBy),
      'studentId': serializer.toJson<int?>(studentId),
      'sessionId': serializer.toJson<int?>(sessionId),
      'amount': serializer.toJson<String?>(amount),
      'fineAmount': serializer.toJson<String?>(fineAmount),
      'accountId': serializer.toJson<int?>(accountId),
      'comments': serializer.toJson<String?>(comments),
      'printed': serializer.toJson<int?>(printed),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  Transaction copyWith(
          {int? id,
          Value<String?> date = const Value.absent(),
          Value<int?> paymentMethod = const Value.absent(),
          Value<String?> paymentGateway = const Value.absent(),
          Value<String?> transactionId = const Value.absent(),
          Value<int?> feesAssignChildrenId = const Value.absent(),
          Value<int?> feesCollectBy = const Value.absent(),
          Value<int?> studentId = const Value.absent(),
          Value<int?> sessionId = const Value.absent(),
          Value<String?> amount = const Value.absent(),
          Value<String?> fineAmount = const Value.absent(),
          Value<int?> accountId = const Value.absent(),
          Value<String?> comments = const Value.absent(),
          Value<int?> printed = const Value.absent(),
          Value<String?> createdAt = const Value.absent(),
          Value<String?> updatedAt = const Value.absent()}) =>
      Transaction(
        id: id ?? this.id,
        date: date.present ? date.value : this.date,
        paymentMethod:
            paymentMethod.present ? paymentMethod.value : this.paymentMethod,
        paymentGateway:
            paymentGateway.present ? paymentGateway.value : this.paymentGateway,
        transactionId:
            transactionId.present ? transactionId.value : this.transactionId,
        feesAssignChildrenId: feesAssignChildrenId.present
            ? feesAssignChildrenId.value
            : this.feesAssignChildrenId,
        feesCollectBy:
            feesCollectBy.present ? feesCollectBy.value : this.feesCollectBy,
        studentId: studentId.present ? studentId.value : this.studentId,
        sessionId: sessionId.present ? sessionId.value : this.sessionId,
        amount: amount.present ? amount.value : this.amount,
        fineAmount: fineAmount.present ? fineAmount.value : this.fineAmount,
        accountId: accountId.present ? accountId.value : this.accountId,
        comments: comments.present ? comments.value : this.comments,
        printed: printed.present ? printed.value : this.printed,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      paymentGateway: data.paymentGateway.present
          ? data.paymentGateway.value
          : this.paymentGateway,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      feesAssignChildrenId: data.feesAssignChildrenId.present
          ? data.feesAssignChildrenId.value
          : this.feesAssignChildrenId,
      feesCollectBy: data.feesCollectBy.present
          ? data.feesCollectBy.value
          : this.feesCollectBy,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      amount: data.amount.present ? data.amount.value : this.amount,
      fineAmount:
          data.fineAmount.present ? data.fineAmount.value : this.fineAmount,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      comments: data.comments.present ? data.comments.value : this.comments,
      printed: data.printed.present ? data.printed.value : this.printed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentGateway: $paymentGateway, ')
          ..write('transactionId: $transactionId, ')
          ..write('feesAssignChildrenId: $feesAssignChildrenId, ')
          ..write('feesCollectBy: $feesCollectBy, ')
          ..write('studentId: $studentId, ')
          ..write('sessionId: $sessionId, ')
          ..write('amount: $amount, ')
          ..write('fineAmount: $fineAmount, ')
          ..write('accountId: $accountId, ')
          ..write('comments: $comments, ')
          ..write('printed: $printed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      date,
      paymentMethod,
      paymentGateway,
      transactionId,
      feesAssignChildrenId,
      feesCollectBy,
      studentId,
      sessionId,
      amount,
      fineAmount,
      accountId,
      comments,
      printed,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.date == this.date &&
          other.paymentMethod == this.paymentMethod &&
          other.paymentGateway == this.paymentGateway &&
          other.transactionId == this.transactionId &&
          other.feesAssignChildrenId == this.feesAssignChildrenId &&
          other.feesCollectBy == this.feesCollectBy &&
          other.studentId == this.studentId &&
          other.sessionId == this.sessionId &&
          other.amount == this.amount &&
          other.fineAmount == this.fineAmount &&
          other.accountId == this.accountId &&
          other.comments == this.comments &&
          other.printed == this.printed &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<String?> date;
  final Value<int?> paymentMethod;
  final Value<String?> paymentGateway;
  final Value<String?> transactionId;
  final Value<int?> feesAssignChildrenId;
  final Value<int?> feesCollectBy;
  final Value<int?> studentId;
  final Value<int?> sessionId;
  final Value<String?> amount;
  final Value<String?> fineAmount;
  final Value<int?> accountId;
  final Value<String?> comments;
  final Value<int?> printed;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paymentGateway = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.feesAssignChildrenId = const Value.absent(),
    this.feesCollectBy = const Value.absent(),
    this.studentId = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.amount = const Value.absent(),
    this.fineAmount = const Value.absent(),
    this.accountId = const Value.absent(),
    this.comments = const Value.absent(),
    this.printed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paymentGateway = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.feesAssignChildrenId = const Value.absent(),
    this.feesCollectBy = const Value.absent(),
    this.studentId = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.amount = const Value.absent(),
    this.fineAmount = const Value.absent(),
    this.accountId = const Value.absent(),
    this.comments = const Value.absent(),
    this.printed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<int>? paymentMethod,
    Expression<String>? paymentGateway,
    Expression<String>? transactionId,
    Expression<int>? feesAssignChildrenId,
    Expression<int>? feesCollectBy,
    Expression<int>? studentId,
    Expression<int>? sessionId,
    Expression<String>? amount,
    Expression<String>? fineAmount,
    Expression<int>? accountId,
    Expression<String>? comments,
    Expression<int>? printed,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (paymentGateway != null) 'payment_gateway': paymentGateway,
      if (transactionId != null) 'transaction_id': transactionId,
      if (feesAssignChildrenId != null)
        'fees_assign_children_id': feesAssignChildrenId,
      if (feesCollectBy != null) 'fees_collect_by': feesCollectBy,
      if (studentId != null) 'student_id': studentId,
      if (sessionId != null) 'session_id': sessionId,
      if (amount != null) 'amount': amount,
      if (fineAmount != null) 'fine_amount': fineAmount,
      if (accountId != null) 'account_id': accountId,
      if (comments != null) 'comments': comments,
      if (printed != null) 'printed': printed,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? date,
      Value<int?>? paymentMethod,
      Value<String?>? paymentGateway,
      Value<String?>? transactionId,
      Value<int?>? feesAssignChildrenId,
      Value<int?>? feesCollectBy,
      Value<int?>? studentId,
      Value<int?>? sessionId,
      Value<String?>? amount,
      Value<String?>? fineAmount,
      Value<int?>? accountId,
      Value<String?>? comments,
      Value<int?>? printed,
      Value<String?>? createdAt,
      Value<String?>? updatedAt}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentGateway: paymentGateway ?? this.paymentGateway,
      transactionId: transactionId ?? this.transactionId,
      feesAssignChildrenId: feesAssignChildrenId ?? this.feesAssignChildrenId,
      feesCollectBy: feesCollectBy ?? this.feesCollectBy,
      studentId: studentId ?? this.studentId,
      sessionId: sessionId ?? this.sessionId,
      amount: amount ?? this.amount,
      fineAmount: fineAmount ?? this.fineAmount,
      accountId: accountId ?? this.accountId,
      comments: comments ?? this.comments,
      printed: printed ?? this.printed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<int>(paymentMethod.value);
    }
    if (paymentGateway.present) {
      map['payment_gateway'] = Variable<String>(paymentGateway.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (feesAssignChildrenId.present) {
      map['fees_assign_children_id'] =
          Variable<int>(feesAssignChildrenId.value);
    }
    if (feesCollectBy.present) {
      map['fees_collect_by'] = Variable<int>(feesCollectBy.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<String>(amount.value);
    }
    if (fineAmount.present) {
      map['fine_amount'] = Variable<String>(fineAmount.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (comments.present) {
      map['comments'] = Variable<String>(comments.value);
    }
    if (printed.present) {
      map['printed'] = Variable<int>(printed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentGateway: $paymentGateway, ')
          ..write('transactionId: $transactionId, ')
          ..write('feesAssignChildrenId: $feesAssignChildrenId, ')
          ..write('feesCollectBy: $feesCollectBy, ')
          ..write('studentId: $studentId, ')
          ..write('sessionId: $sessionId, ')
          ..write('amount: $amount, ')
          ..write('fineAmount: $fineAmount, ')
          ..write('accountId: $accountId, ')
          ..write('comments: $comments, ')
          ..write('printed: $printed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AgentCommissionsTable extends AgentCommissions
    with TableInfo<$AgentCommissionsTable, AgentCommission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgentCommissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<String> totalAmount = GeneratedColumn<String>(
      'total_amount', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalTransactionsMeta =
      const VerificationMeta('totalTransactions');
  @override
  late final GeneratedColumn<String> totalTransactions =
      GeneratedColumn<String>('total_transactions', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _merchantIdMeta =
      const VerificationMeta('merchantId');
  @override
  late final GeneratedColumn<String> merchantId = GeneratedColumn<String>(
      'merchant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, totalAmount, totalTransactions, merchantId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'agent_commissions';
  @override
  VerificationContext validateIntegrity(Insertable<AgentCommission> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('total_transactions')) {
      context.handle(
          _totalTransactionsMeta,
          totalTransactions.isAcceptableOrUnknown(
              data['total_transactions']!, _totalTransactionsMeta));
    } else if (isInserting) {
      context.missing(_totalTransactionsMeta);
    }
    if (data.containsKey('merchant_id')) {
      context.handle(
          _merchantIdMeta,
          merchantId.isAcceptableOrUnknown(
              data['merchant_id']!, _merchantIdMeta));
    } else if (isInserting) {
      context.missing(_merchantIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AgentCommission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgentCommission(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}total_amount'])!,
      totalTransactions: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}total_transactions'])!,
      merchantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}merchant_id'])!,
    );
  }

  @override
  $AgentCommissionsTable createAlias(String alias) {
    return $AgentCommissionsTable(attachedDatabase, alias);
  }
}

class AgentCommission extends DataClass implements Insertable<AgentCommission> {
  final int id;
  final String totalAmount;
  final String totalTransactions;
  final String merchantId;
  const AgentCommission(
      {required this.id,
      required this.totalAmount,
      required this.totalTransactions,
      required this.merchantId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_amount'] = Variable<String>(totalAmount);
    map['total_transactions'] = Variable<String>(totalTransactions);
    map['merchant_id'] = Variable<String>(merchantId);
    return map;
  }

  AgentCommissionsCompanion toCompanion(bool nullToAbsent) {
    return AgentCommissionsCompanion(
      id: Value(id),
      totalAmount: Value(totalAmount),
      totalTransactions: Value(totalTransactions),
      merchantId: Value(merchantId),
    );
  }

  factory AgentCommission.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgentCommission(
      id: serializer.fromJson<int>(json['id']),
      totalAmount: serializer.fromJson<String>(json['totalAmount']),
      totalTransactions: serializer.fromJson<String>(json['totalTransactions']),
      merchantId: serializer.fromJson<String>(json['merchantId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalAmount': serializer.toJson<String>(totalAmount),
      'totalTransactions': serializer.toJson<String>(totalTransactions),
      'merchantId': serializer.toJson<String>(merchantId),
    };
  }

  AgentCommission copyWith(
          {int? id,
          String? totalAmount,
          String? totalTransactions,
          String? merchantId}) =>
      AgentCommission(
        id: id ?? this.id,
        totalAmount: totalAmount ?? this.totalAmount,
        totalTransactions: totalTransactions ?? this.totalTransactions,
        merchantId: merchantId ?? this.merchantId,
      );
  AgentCommission copyWithCompanion(AgentCommissionsCompanion data) {
    return AgentCommission(
      id: data.id.present ? data.id.value : this.id,
      totalAmount:
          data.totalAmount.present ? data.totalAmount.value : this.totalAmount,
      totalTransactions: data.totalTransactions.present
          ? data.totalTransactions.value
          : this.totalTransactions,
      merchantId:
          data.merchantId.present ? data.merchantId.value : this.merchantId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgentCommission(')
          ..write('id: $id, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('totalTransactions: $totalTransactions, ')
          ..write('merchantId: $merchantId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, totalAmount, totalTransactions, merchantId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgentCommission &&
          other.id == this.id &&
          other.totalAmount == this.totalAmount &&
          other.totalTransactions == this.totalTransactions &&
          other.merchantId == this.merchantId);
}

class AgentCommissionsCompanion extends UpdateCompanion<AgentCommission> {
  final Value<int> id;
  final Value<String> totalAmount;
  final Value<String> totalTransactions;
  final Value<String> merchantId;
  const AgentCommissionsCompanion({
    this.id = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.totalTransactions = const Value.absent(),
    this.merchantId = const Value.absent(),
  });
  AgentCommissionsCompanion.insert({
    this.id = const Value.absent(),
    required String totalAmount,
    required String totalTransactions,
    required String merchantId,
  })  : totalAmount = Value(totalAmount),
        totalTransactions = Value(totalTransactions),
        merchantId = Value(merchantId);
  static Insertable<AgentCommission> custom({
    Expression<int>? id,
    Expression<String>? totalAmount,
    Expression<String>? totalTransactions,
    Expression<String>? merchantId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (totalTransactions != null) 'total_transactions': totalTransactions,
      if (merchantId != null) 'merchant_id': merchantId,
    });
  }

  AgentCommissionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? totalAmount,
      Value<String>? totalTransactions,
      Value<String>? merchantId}) {
    return AgentCommissionsCompanion(
      id: id ?? this.id,
      totalAmount: totalAmount ?? this.totalAmount,
      totalTransactions: totalTransactions ?? this.totalTransactions,
      merchantId: merchantId ?? this.merchantId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<String>(totalAmount.value);
    }
    if (totalTransactions.present) {
      map['total_transactions'] = Variable<String>(totalTransactions.value);
    }
    if (merchantId.present) {
      map['merchant_id'] = Variable<String>(merchantId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgentCommissionsCompanion(')
          ..write('id: $id, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('totalTransactions: $totalTransactions, ')
          ..write('merchantId: $merchantId')
          ..write(')'))
        .toString();
  }
}

class $PaymentTransactionsTable extends PaymentTransactions
    with TableInfo<$PaymentTransactionsTable, PaymentTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _msisdnMeta = const VerificationMeta('msisdn');
  @override
  late final GeneratedColumn<String> msisdn = GeneratedColumn<String>(
      'msisdn', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mechantIdMeta =
      const VerificationMeta('mechantId');
  @override
  late final GeneratedColumn<int> mechantId = GeneratedColumn<int>(
      'mechant_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _settlementStatusMeta =
      const VerificationMeta('settlementStatus');
  @override
  late final GeneratedColumn<String> settlementStatus = GeneratedColumn<String>(
      'settlement_status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _chargeMeta = const VerificationMeta('charge');
  @override
  late final GeneratedColumn<String> charge = GeneratedColumn<String>(
      'charge', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _receivingAccountIdMeta =
      const VerificationMeta('receivingAccountId');
  @override
  late final GeneratedColumn<String> receivingAccountId =
      GeneratedColumn<String>('receiving_account_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<String> totalAmount = GeneratedColumn<String>(
      'total_amount', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
      'transaction_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _settlementIdMeta =
      const VerificationMeta('settlementId');
  @override
  late final GeneratedColumn<String> settlementId = GeneratedColumn<String>(
      'settlement_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _settlementDateMeta =
      const VerificationMeta('settlementDate');
  @override
  late final GeneratedColumn<String> settlementDate = GeneratedColumn<String>(
      'settlement_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _settlementAccountMeta =
      const VerificationMeta('settlementAccount');
  @override
  late final GeneratedColumn<String> settlementAccount =
      GeneratedColumn<String>('settlement_account', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _settlementTypeMeta =
      const VerificationMeta('settlementType');
  @override
  late final GeneratedColumn<String> settlementType = GeneratedColumn<String>(
      'settlement_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _agentIdMeta =
      const VerificationMeta('agentId');
  @override
  late final GeneratedColumn<String> agentId = GeneratedColumn<String>(
      'agent_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _callbackReceivedAtMeta =
      const VerificationMeta('callbackReceivedAt');
  @override
  late final GeneratedColumn<String> callbackReceivedAt =
      GeneratedColumn<String>('callback_received_at', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _callbackDataMeta =
      const VerificationMeta('callbackData');
  @override
  late final GeneratedColumn<String> callbackData = GeneratedColumn<String>(
      'callback_data', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        msisdn,
        amount,
        reference,
        type,
        status,
        mechantId,
        settlementStatus,
        charge,
        receivingAccountId,
        totalAmount,
        transactionId,
        settlementId,
        settlementDate,
        settlementAccount,
        settlementType,
        agentId,
        createdAt,
        updatedAt,
        callbackReceivedAt,
        callbackData
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_transactions';
  @override
  VerificationContext validateIntegrity(Insertable<PaymentTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('msisdn')) {
      context.handle(_msisdnMeta,
          msisdn.isAcceptableOrUnknown(data['msisdn']!, _msisdnMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('mechant_id')) {
      context.handle(_mechantIdMeta,
          mechantId.isAcceptableOrUnknown(data['mechant_id']!, _mechantIdMeta));
    }
    if (data.containsKey('settlement_status')) {
      context.handle(
          _settlementStatusMeta,
          settlementStatus.isAcceptableOrUnknown(
              data['settlement_status']!, _settlementStatusMeta));
    }
    if (data.containsKey('charge')) {
      context.handle(_chargeMeta,
          charge.isAcceptableOrUnknown(data['charge']!, _chargeMeta));
    }
    if (data.containsKey('receiving_account_id')) {
      context.handle(
          _receivingAccountIdMeta,
          receivingAccountId.isAcceptableOrUnknown(
              data['receiving_account_id']!, _receivingAccountIdMeta));
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    }
    if (data.containsKey('settlement_id')) {
      context.handle(
          _settlementIdMeta,
          settlementId.isAcceptableOrUnknown(
              data['settlement_id']!, _settlementIdMeta));
    }
    if (data.containsKey('settlement_date')) {
      context.handle(
          _settlementDateMeta,
          settlementDate.isAcceptableOrUnknown(
              data['settlement_date']!, _settlementDateMeta));
    }
    if (data.containsKey('settlement_account')) {
      context.handle(
          _settlementAccountMeta,
          settlementAccount.isAcceptableOrUnknown(
              data['settlement_account']!, _settlementAccountMeta));
    }
    if (data.containsKey('settlement_type')) {
      context.handle(
          _settlementTypeMeta,
          settlementType.isAcceptableOrUnknown(
              data['settlement_type']!, _settlementTypeMeta));
    }
    if (data.containsKey('agent_id')) {
      context.handle(_agentIdMeta,
          agentId.isAcceptableOrUnknown(data['agent_id']!, _agentIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('callback_received_at')) {
      context.handle(
          _callbackReceivedAtMeta,
          callbackReceivedAt.isAcceptableOrUnknown(
              data['callback_received_at']!, _callbackReceivedAtMeta));
    }
    if (data.containsKey('callback_data')) {
      context.handle(
          _callbackDataMeta,
          callbackData.isAcceptableOrUnknown(
              data['callback_data']!, _callbackDataMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentTransaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      msisdn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}msisdn']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount']),
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      mechantId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mechant_id']),
      settlementStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}settlement_status']),
      charge: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}charge']),
      receivingAccountId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}receiving_account_id']),
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}total_amount']),
      transactionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transaction_id']),
      settlementId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}settlement_id']),
      settlementDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}settlement_date']),
      settlementAccount: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}settlement_account']),
      settlementType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}settlement_type']),
      agentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agent_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at']),
      callbackReceivedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}callback_received_at']),
      callbackData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}callback_data']),
    );
  }

  @override
  $PaymentTransactionsTable createAlias(String alias) {
    return $PaymentTransactionsTable(attachedDatabase, alias);
  }
}

class PaymentTransaction extends DataClass
    implements Insertable<PaymentTransaction> {
  final int id;
  final String? msisdn;
  final double? amount;
  final String? reference;
  final String? type;
  final String? status;
  final int? mechantId;
  final String? settlementStatus;
  final String? charge;
  final String? receivingAccountId;
  final String? totalAmount;
  final String? transactionId;
  final String? settlementId;
  final String? settlementDate;
  final String? settlementAccount;
  final String? settlementType;
  final String? agentId;
  final String? createdAt;
  final String? updatedAt;
  final String? callbackReceivedAt;
  final String? callbackData;
  const PaymentTransaction(
      {required this.id,
      this.msisdn,
      this.amount,
      this.reference,
      this.type,
      this.status,
      this.mechantId,
      this.settlementStatus,
      this.charge,
      this.receivingAccountId,
      this.totalAmount,
      this.transactionId,
      this.settlementId,
      this.settlementDate,
      this.settlementAccount,
      this.settlementType,
      this.agentId,
      this.createdAt,
      this.updatedAt,
      this.callbackReceivedAt,
      this.callbackData});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || msisdn != null) {
      map['msisdn'] = Variable<String>(msisdn);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || mechantId != null) {
      map['mechant_id'] = Variable<int>(mechantId);
    }
    if (!nullToAbsent || settlementStatus != null) {
      map['settlement_status'] = Variable<String>(settlementStatus);
    }
    if (!nullToAbsent || charge != null) {
      map['charge'] = Variable<String>(charge);
    }
    if (!nullToAbsent || receivingAccountId != null) {
      map['receiving_account_id'] = Variable<String>(receivingAccountId);
    }
    if (!nullToAbsent || totalAmount != null) {
      map['total_amount'] = Variable<String>(totalAmount);
    }
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<String>(transactionId);
    }
    if (!nullToAbsent || settlementId != null) {
      map['settlement_id'] = Variable<String>(settlementId);
    }
    if (!nullToAbsent || settlementDate != null) {
      map['settlement_date'] = Variable<String>(settlementDate);
    }
    if (!nullToAbsent || settlementAccount != null) {
      map['settlement_account'] = Variable<String>(settlementAccount);
    }
    if (!nullToAbsent || settlementType != null) {
      map['settlement_type'] = Variable<String>(settlementType);
    }
    if (!nullToAbsent || agentId != null) {
      map['agent_id'] = Variable<String>(agentId);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    if (!nullToAbsent || callbackReceivedAt != null) {
      map['callback_received_at'] = Variable<String>(callbackReceivedAt);
    }
    if (!nullToAbsent || callbackData != null) {
      map['callback_data'] = Variable<String>(callbackData);
    }
    return map;
  }

  PaymentTransactionsCompanion toCompanion(bool nullToAbsent) {
    return PaymentTransactionsCompanion(
      id: Value(id),
      msisdn:
          msisdn == null && nullToAbsent ? const Value.absent() : Value(msisdn),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      mechantId: mechantId == null && nullToAbsent
          ? const Value.absent()
          : Value(mechantId),
      settlementStatus: settlementStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(settlementStatus),
      charge:
          charge == null && nullToAbsent ? const Value.absent() : Value(charge),
      receivingAccountId: receivingAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(receivingAccountId),
      totalAmount: totalAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(totalAmount),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      settlementId: settlementId == null && nullToAbsent
          ? const Value.absent()
          : Value(settlementId),
      settlementDate: settlementDate == null && nullToAbsent
          ? const Value.absent()
          : Value(settlementDate),
      settlementAccount: settlementAccount == null && nullToAbsent
          ? const Value.absent()
          : Value(settlementAccount),
      settlementType: settlementType == null && nullToAbsent
          ? const Value.absent()
          : Value(settlementType),
      agentId: agentId == null && nullToAbsent
          ? const Value.absent()
          : Value(agentId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      callbackReceivedAt: callbackReceivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(callbackReceivedAt),
      callbackData: callbackData == null && nullToAbsent
          ? const Value.absent()
          : Value(callbackData),
    );
  }

  factory PaymentTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentTransaction(
      id: serializer.fromJson<int>(json['id']),
      msisdn: serializer.fromJson<String?>(json['msisdn']),
      amount: serializer.fromJson<double?>(json['amount']),
      reference: serializer.fromJson<String?>(json['reference']),
      type: serializer.fromJson<String?>(json['type']),
      status: serializer.fromJson<String?>(json['status']),
      mechantId: serializer.fromJson<int?>(json['mechantId']),
      settlementStatus: serializer.fromJson<String?>(json['settlementStatus']),
      charge: serializer.fromJson<String?>(json['charge']),
      receivingAccountId:
          serializer.fromJson<String?>(json['receivingAccountId']),
      totalAmount: serializer.fromJson<String?>(json['totalAmount']),
      transactionId: serializer.fromJson<String?>(json['transactionId']),
      settlementId: serializer.fromJson<String?>(json['settlementId']),
      settlementDate: serializer.fromJson<String?>(json['settlementDate']),
      settlementAccount:
          serializer.fromJson<String?>(json['settlementAccount']),
      settlementType: serializer.fromJson<String?>(json['settlementType']),
      agentId: serializer.fromJson<String?>(json['agentId']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
      callbackReceivedAt:
          serializer.fromJson<String?>(json['callbackReceivedAt']),
      callbackData: serializer.fromJson<String?>(json['callbackData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'msisdn': serializer.toJson<String?>(msisdn),
      'amount': serializer.toJson<double?>(amount),
      'reference': serializer.toJson<String?>(reference),
      'type': serializer.toJson<String?>(type),
      'status': serializer.toJson<String?>(status),
      'mechantId': serializer.toJson<int?>(mechantId),
      'settlementStatus': serializer.toJson<String?>(settlementStatus),
      'charge': serializer.toJson<String?>(charge),
      'receivingAccountId': serializer.toJson<String?>(receivingAccountId),
      'totalAmount': serializer.toJson<String?>(totalAmount),
      'transactionId': serializer.toJson<String?>(transactionId),
      'settlementId': serializer.toJson<String?>(settlementId),
      'settlementDate': serializer.toJson<String?>(settlementDate),
      'settlementAccount': serializer.toJson<String?>(settlementAccount),
      'settlementType': serializer.toJson<String?>(settlementType),
      'agentId': serializer.toJson<String?>(agentId),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
      'callbackReceivedAt': serializer.toJson<String?>(callbackReceivedAt),
      'callbackData': serializer.toJson<String?>(callbackData),
    };
  }

  PaymentTransaction copyWith(
          {int? id,
          Value<String?> msisdn = const Value.absent(),
          Value<double?> amount = const Value.absent(),
          Value<String?> reference = const Value.absent(),
          Value<String?> type = const Value.absent(),
          Value<String?> status = const Value.absent(),
          Value<int?> mechantId = const Value.absent(),
          Value<String?> settlementStatus = const Value.absent(),
          Value<String?> charge = const Value.absent(),
          Value<String?> receivingAccountId = const Value.absent(),
          Value<String?> totalAmount = const Value.absent(),
          Value<String?> transactionId = const Value.absent(),
          Value<String?> settlementId = const Value.absent(),
          Value<String?> settlementDate = const Value.absent(),
          Value<String?> settlementAccount = const Value.absent(),
          Value<String?> settlementType = const Value.absent(),
          Value<String?> agentId = const Value.absent(),
          Value<String?> createdAt = const Value.absent(),
          Value<String?> updatedAt = const Value.absent(),
          Value<String?> callbackReceivedAt = const Value.absent(),
          Value<String?> callbackData = const Value.absent()}) =>
      PaymentTransaction(
        id: id ?? this.id,
        msisdn: msisdn.present ? msisdn.value : this.msisdn,
        amount: amount.present ? amount.value : this.amount,
        reference: reference.present ? reference.value : this.reference,
        type: type.present ? type.value : this.type,
        status: status.present ? status.value : this.status,
        mechantId: mechantId.present ? mechantId.value : this.mechantId,
        settlementStatus: settlementStatus.present
            ? settlementStatus.value
            : this.settlementStatus,
        charge: charge.present ? charge.value : this.charge,
        receivingAccountId: receivingAccountId.present
            ? receivingAccountId.value
            : this.receivingAccountId,
        totalAmount: totalAmount.present ? totalAmount.value : this.totalAmount,
        transactionId:
            transactionId.present ? transactionId.value : this.transactionId,
        settlementId:
            settlementId.present ? settlementId.value : this.settlementId,
        settlementDate:
            settlementDate.present ? settlementDate.value : this.settlementDate,
        settlementAccount: settlementAccount.present
            ? settlementAccount.value
            : this.settlementAccount,
        settlementType:
            settlementType.present ? settlementType.value : this.settlementType,
        agentId: agentId.present ? agentId.value : this.agentId,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        callbackReceivedAt: callbackReceivedAt.present
            ? callbackReceivedAt.value
            : this.callbackReceivedAt,
        callbackData:
            callbackData.present ? callbackData.value : this.callbackData,
      );
  PaymentTransaction copyWithCompanion(PaymentTransactionsCompanion data) {
    return PaymentTransaction(
      id: data.id.present ? data.id.value : this.id,
      msisdn: data.msisdn.present ? data.msisdn.value : this.msisdn,
      amount: data.amount.present ? data.amount.value : this.amount,
      reference: data.reference.present ? data.reference.value : this.reference,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      mechantId: data.mechantId.present ? data.mechantId.value : this.mechantId,
      settlementStatus: data.settlementStatus.present
          ? data.settlementStatus.value
          : this.settlementStatus,
      charge: data.charge.present ? data.charge.value : this.charge,
      receivingAccountId: data.receivingAccountId.present
          ? data.receivingAccountId.value
          : this.receivingAccountId,
      totalAmount:
          data.totalAmount.present ? data.totalAmount.value : this.totalAmount,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      settlementId: data.settlementId.present
          ? data.settlementId.value
          : this.settlementId,
      settlementDate: data.settlementDate.present
          ? data.settlementDate.value
          : this.settlementDate,
      settlementAccount: data.settlementAccount.present
          ? data.settlementAccount.value
          : this.settlementAccount,
      settlementType: data.settlementType.present
          ? data.settlementType.value
          : this.settlementType,
      agentId: data.agentId.present ? data.agentId.value : this.agentId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      callbackReceivedAt: data.callbackReceivedAt.present
          ? data.callbackReceivedAt.value
          : this.callbackReceivedAt,
      callbackData: data.callbackData.present
          ? data.callbackData.value
          : this.callbackData,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentTransaction(')
          ..write('id: $id, ')
          ..write('msisdn: $msisdn, ')
          ..write('amount: $amount, ')
          ..write('reference: $reference, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('mechantId: $mechantId, ')
          ..write('settlementStatus: $settlementStatus, ')
          ..write('charge: $charge, ')
          ..write('receivingAccountId: $receivingAccountId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('transactionId: $transactionId, ')
          ..write('settlementId: $settlementId, ')
          ..write('settlementDate: $settlementDate, ')
          ..write('settlementAccount: $settlementAccount, ')
          ..write('settlementType: $settlementType, ')
          ..write('agentId: $agentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('callbackReceivedAt: $callbackReceivedAt, ')
          ..write('callbackData: $callbackData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        msisdn,
        amount,
        reference,
        type,
        status,
        mechantId,
        settlementStatus,
        charge,
        receivingAccountId,
        totalAmount,
        transactionId,
        settlementId,
        settlementDate,
        settlementAccount,
        settlementType,
        agentId,
        createdAt,
        updatedAt,
        callbackReceivedAt,
        callbackData
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentTransaction &&
          other.id == this.id &&
          other.msisdn == this.msisdn &&
          other.amount == this.amount &&
          other.reference == this.reference &&
          other.type == this.type &&
          other.status == this.status &&
          other.mechantId == this.mechantId &&
          other.settlementStatus == this.settlementStatus &&
          other.charge == this.charge &&
          other.receivingAccountId == this.receivingAccountId &&
          other.totalAmount == this.totalAmount &&
          other.transactionId == this.transactionId &&
          other.settlementId == this.settlementId &&
          other.settlementDate == this.settlementDate &&
          other.settlementAccount == this.settlementAccount &&
          other.settlementType == this.settlementType &&
          other.agentId == this.agentId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.callbackReceivedAt == this.callbackReceivedAt &&
          other.callbackData == this.callbackData);
}

class PaymentTransactionsCompanion extends UpdateCompanion<PaymentTransaction> {
  final Value<int> id;
  final Value<String?> msisdn;
  final Value<double?> amount;
  final Value<String?> reference;
  final Value<String?> type;
  final Value<String?> status;
  final Value<int?> mechantId;
  final Value<String?> settlementStatus;
  final Value<String?> charge;
  final Value<String?> receivingAccountId;
  final Value<String?> totalAmount;
  final Value<String?> transactionId;
  final Value<String?> settlementId;
  final Value<String?> settlementDate;
  final Value<String?> settlementAccount;
  final Value<String?> settlementType;
  final Value<String?> agentId;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<String?> callbackReceivedAt;
  final Value<String?> callbackData;
  const PaymentTransactionsCompanion({
    this.id = const Value.absent(),
    this.msisdn = const Value.absent(),
    this.amount = const Value.absent(),
    this.reference = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.mechantId = const Value.absent(),
    this.settlementStatus = const Value.absent(),
    this.charge = const Value.absent(),
    this.receivingAccountId = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.settlementId = const Value.absent(),
    this.settlementDate = const Value.absent(),
    this.settlementAccount = const Value.absent(),
    this.settlementType = const Value.absent(),
    this.agentId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.callbackReceivedAt = const Value.absent(),
    this.callbackData = const Value.absent(),
  });
  PaymentTransactionsCompanion.insert({
    this.id = const Value.absent(),
    this.msisdn = const Value.absent(),
    this.amount = const Value.absent(),
    this.reference = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.mechantId = const Value.absent(),
    this.settlementStatus = const Value.absent(),
    this.charge = const Value.absent(),
    this.receivingAccountId = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.settlementId = const Value.absent(),
    this.settlementDate = const Value.absent(),
    this.settlementAccount = const Value.absent(),
    this.settlementType = const Value.absent(),
    this.agentId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.callbackReceivedAt = const Value.absent(),
    this.callbackData = const Value.absent(),
  });
  static Insertable<PaymentTransaction> custom({
    Expression<int>? id,
    Expression<String>? msisdn,
    Expression<double>? amount,
    Expression<String>? reference,
    Expression<String>? type,
    Expression<String>? status,
    Expression<int>? mechantId,
    Expression<String>? settlementStatus,
    Expression<String>? charge,
    Expression<String>? receivingAccountId,
    Expression<String>? totalAmount,
    Expression<String>? transactionId,
    Expression<String>? settlementId,
    Expression<String>? settlementDate,
    Expression<String>? settlementAccount,
    Expression<String>? settlementType,
    Expression<String>? agentId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? callbackReceivedAt,
    Expression<String>? callbackData,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (msisdn != null) 'msisdn': msisdn,
      if (amount != null) 'amount': amount,
      if (reference != null) 'reference': reference,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (mechantId != null) 'mechant_id': mechantId,
      if (settlementStatus != null) 'settlement_status': settlementStatus,
      if (charge != null) 'charge': charge,
      if (receivingAccountId != null)
        'receiving_account_id': receivingAccountId,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (transactionId != null) 'transaction_id': transactionId,
      if (settlementId != null) 'settlement_id': settlementId,
      if (settlementDate != null) 'settlement_date': settlementDate,
      if (settlementAccount != null) 'settlement_account': settlementAccount,
      if (settlementType != null) 'settlement_type': settlementType,
      if (agentId != null) 'agent_id': agentId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (callbackReceivedAt != null)
        'callback_received_at': callbackReceivedAt,
      if (callbackData != null) 'callback_data': callbackData,
    });
  }

  PaymentTransactionsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? msisdn,
      Value<double?>? amount,
      Value<String?>? reference,
      Value<String?>? type,
      Value<String?>? status,
      Value<int?>? mechantId,
      Value<String?>? settlementStatus,
      Value<String?>? charge,
      Value<String?>? receivingAccountId,
      Value<String?>? totalAmount,
      Value<String?>? transactionId,
      Value<String?>? settlementId,
      Value<String?>? settlementDate,
      Value<String?>? settlementAccount,
      Value<String?>? settlementType,
      Value<String?>? agentId,
      Value<String?>? createdAt,
      Value<String?>? updatedAt,
      Value<String?>? callbackReceivedAt,
      Value<String?>? callbackData}) {
    return PaymentTransactionsCompanion(
      id: id ?? this.id,
      msisdn: msisdn ?? this.msisdn,
      amount: amount ?? this.amount,
      reference: reference ?? this.reference,
      type: type ?? this.type,
      status: status ?? this.status,
      mechantId: mechantId ?? this.mechantId,
      settlementStatus: settlementStatus ?? this.settlementStatus,
      charge: charge ?? this.charge,
      receivingAccountId: receivingAccountId ?? this.receivingAccountId,
      totalAmount: totalAmount ?? this.totalAmount,
      transactionId: transactionId ?? this.transactionId,
      settlementId: settlementId ?? this.settlementId,
      settlementDate: settlementDate ?? this.settlementDate,
      settlementAccount: settlementAccount ?? this.settlementAccount,
      settlementType: settlementType ?? this.settlementType,
      agentId: agentId ?? this.agentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      callbackReceivedAt: callbackReceivedAt ?? this.callbackReceivedAt,
      callbackData: callbackData ?? this.callbackData,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (msisdn.present) {
      map['msisdn'] = Variable<String>(msisdn.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (mechantId.present) {
      map['mechant_id'] = Variable<int>(mechantId.value);
    }
    if (settlementStatus.present) {
      map['settlement_status'] = Variable<String>(settlementStatus.value);
    }
    if (charge.present) {
      map['charge'] = Variable<String>(charge.value);
    }
    if (receivingAccountId.present) {
      map['receiving_account_id'] = Variable<String>(receivingAccountId.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<String>(totalAmount.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (settlementId.present) {
      map['settlement_id'] = Variable<String>(settlementId.value);
    }
    if (settlementDate.present) {
      map['settlement_date'] = Variable<String>(settlementDate.value);
    }
    if (settlementAccount.present) {
      map['settlement_account'] = Variable<String>(settlementAccount.value);
    }
    if (settlementType.present) {
      map['settlement_type'] = Variable<String>(settlementType.value);
    }
    if (agentId.present) {
      map['agent_id'] = Variable<String>(agentId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (callbackReceivedAt.present) {
      map['callback_received_at'] = Variable<String>(callbackReceivedAt.value);
    }
    if (callbackData.present) {
      map['callback_data'] = Variable<String>(callbackData.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('msisdn: $msisdn, ')
          ..write('amount: $amount, ')
          ..write('reference: $reference, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('mechantId: $mechantId, ')
          ..write('settlementStatus: $settlementStatus, ')
          ..write('charge: $charge, ')
          ..write('receivingAccountId: $receivingAccountId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('transactionId: $transactionId, ')
          ..write('settlementId: $settlementId, ')
          ..write('settlementDate: $settlementDate, ')
          ..write('settlementAccount: $settlementAccount, ')
          ..write('settlementType: $settlementType, ')
          ..write('agentId: $agentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('callbackReceivedAt: $callbackReceivedAt, ')
          ..write('callbackData: $callbackData')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftPlatformDatabase extends GeneratedDatabase {
  _$DriftPlatformDatabase(QueryExecutor e) : super(e);
  $DriftPlatformDatabaseManager get managers =>
      $DriftPlatformDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $MerchantsTable merchants = $MerchantsTable(this);
  late final $BalancesTable balances = $BalancesTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $AccountSetupsTable accountSetups = $AccountSetupsTable(this);
  late final $StatusTable status = $StatusTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $AgentCommissionsTable agentCommissions =
      $AgentCommissionsTable(this);
  late final $PaymentTransactionsTable paymentTransactions =
      $PaymentTransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        merchants,
        balances,
        customers,
        accountSetups,
        status,
        transactions,
        agentCommissions,
        paymentTransactions
      ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String?> phone,
  Value<String?> identificationNumber,
  Value<String?> email,
  Value<String?> username,
  Value<String?> password,
  Value<String?> status,
  Value<String?> otp,
  Value<String?> otpVerified,
  Value<String?> createdAt,
  Value<String?> updatedAt,
  Value<String?> changePassword,
  Value<String?> commissionCharge,
  Value<String?> admissionCharge,
  Value<String> qrLink,
  Value<String?> merchantNumber,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String?> phone,
  Value<String?> identificationNumber,
  Value<String?> email,
  Value<String?> username,
  Value<String?> password,
  Value<String?> status,
  Value<String?> otp,
  Value<String?> otpVerified,
  Value<String?> createdAt,
  Value<String?> updatedAt,
  Value<String?> changePassword,
  Value<String?> commissionCharge,
  Value<String?> admissionCharge,
  Value<String> qrLink,
  Value<String?> merchantNumber,
});

class $$UsersTableFilterComposer
    extends Composer<_$DriftPlatformDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get identificationNumber => $composableBuilder(
      column: $table.identificationNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get otp => $composableBuilder(
      column: $table.otp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get otpVerified => $composableBuilder(
      column: $table.otpVerified, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get changePassword => $composableBuilder(
      column: $table.changePassword,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get commissionCharge => $composableBuilder(
      column: $table.commissionCharge,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get admissionCharge => $composableBuilder(
      column: $table.admissionCharge,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get qrLink => $composableBuilder(
      column: $table.qrLink, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get merchantNumber => $composableBuilder(
      column: $table.merchantNumber,
      builder: (column) => ColumnFilters(column));
}

class $$UsersTableOrderingComposer
    extends Composer<_$DriftPlatformDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get identificationNumber => $composableBuilder(
      column: $table.identificationNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get otp => $composableBuilder(
      column: $table.otp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get otpVerified => $composableBuilder(
      column: $table.otpVerified, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get changePassword => $composableBuilder(
      column: $table.changePassword,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get commissionCharge => $composableBuilder(
      column: $table.commissionCharge,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get admissionCharge => $composableBuilder(
      column: $table.admissionCharge,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get qrLink => $composableBuilder(
      column: $table.qrLink, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get merchantNumber => $composableBuilder(
      column: $table.merchantNumber,
      builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$DriftPlatformDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get identificationNumber => $composableBuilder(
      column: $table.identificationNumber, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get otp =>
      $composableBuilder(column: $table.otp, builder: (column) => column);

  GeneratedColumn<String> get otpVerified => $composableBuilder(
      column: $table.otpVerified, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get changePassword => $composableBuilder(
      column: $table.changePassword, builder: (column) => column);

  GeneratedColumn<String> get commissionCharge => $composableBuilder(
      column: $table.commissionCharge, builder: (column) => column);

  GeneratedColumn<String> get admissionCharge => $composableBuilder(
      column: $table.admissionCharge, builder: (column) => column);

  GeneratedColumn<String> get qrLink =>
      $composableBuilder(column: $table.qrLink, builder: (column) => column);

  GeneratedColumn<String> get merchantNumber => $composableBuilder(
      column: $table.merchantNumber, builder: (column) => column);
}

class $$UsersTableTableManager extends RootTableManager<
    _$DriftPlatformDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$DriftPlatformDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()> {
  $$UsersTableTableManager(_$DriftPlatformDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> identificationNumber = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> password = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<String?> otp = const Value.absent(),
            Value<String?> otpVerified = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
            Value<String?> changePassword = const Value.absent(),
            Value<String?> commissionCharge = const Value.absent(),
            Value<String?> admissionCharge = const Value.absent(),
            Value<String> qrLink = const Value.absent(),
            Value<String?> merchantNumber = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            name: name,
            phone: phone,
            identificationNumber: identificationNumber,
            email: email,
            username: username,
            password: password,
            status: status,
            otp: otp,
            otpVerified: otpVerified,
            createdAt: createdAt,
            updatedAt: updatedAt,
            changePassword: changePassword,
            commissionCharge: commissionCharge,
            admissionCharge: admissionCharge,
            qrLink: qrLink,
            merchantNumber: merchantNumber,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> identificationNumber = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> password = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<String?> otp = const Value.absent(),
            Value<String?> otpVerified = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
            Value<String?> changePassword = const Value.absent(),
            Value<String?> commissionCharge = const Value.absent(),
            Value<String?> admissionCharge = const Value.absent(),
            Value<String> qrLink = const Value.absent(),
            Value<String?> merchantNumber = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            name: name,
            phone: phone,
            identificationNumber: identificationNumber,
            email: email,
            username: username,
            password: password,
            status: status,
            otp: otp,
            otpVerified: otpVerified,
            createdAt: createdAt,
            updatedAt: updatedAt,
            changePassword: changePassword,
            commissionCharge: commissionCharge,
            admissionCharge: admissionCharge,
            qrLink: qrLink,
            merchantNumber: merchantNumber,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$DriftPlatformDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$DriftPlatformDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()>;
typedef $$MerchantsTableCreateCompanionBuilder = MerchantsCompanion Function({
  Value<int> id,
  required String mechantCode,
  required String name,
  required String phone,
  required String password,
  Value<String?> email,
  required String identificationNumber,
  Value<String?> licenceNumber,
  required String documentReferenceId,
  Value<String> status,
  Value<int?> agentId,
  Value<int?> userId,
  Value<String?> createdAt,
  Value<String?> updatedAt,
  Value<String?> otp,
  Value<String?> comments,
  Value<String?> otpVerified,
  Value<String?> tin,
  Value<String?> changePassword,
  Value<String> qrLink,
  Value<String?> merchantNumber,
});
typedef $$MerchantsTableUpdateCompanionBuilder = MerchantsCompanion Function({
  Value<int> id,
  Value<String> mechantCode,
  Value<String> name,
  Value<String> phone,
  Value<String> password,
  Value<String?> email,
  Value<String> identificationNumber,
  Value<String?> licenceNumber,
  Value<String> documentReferenceId,
  Value<String> status,
  Value<int?> agentId,
  Value<int?> userId,
  Value<String?> createdAt,
  Value<String?> updatedAt,
  Value<String?> otp,
  Value<String?> comments,
  Value<String?> otpVerified,
  Value<String?> tin,
  Value<String?> changePassword,
  Value<String> qrLink,
  Value<String?> merchantNumber,
});

class $$MerchantsTableFilterComposer
    extends Composer<_$DriftPlatformDatabase, $MerchantsTable> {
  $$MerchantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mechantCode => $composableBuilder(
      column: $table.mechantCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get identificationNumber => $composableBuilder(
      column: $table.identificationNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get licenceNumber => $composableBuilder(
      column: $table.licenceNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get documentReferenceId => $composableBuilder(
      column: $table.documentReferenceId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get agentId => $composableBuilder(
      column: $table.agentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get otp => $composableBuilder(
      column: $table.otp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get comments => $composableBuilder(
      column: $table.comments, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get otpVerified => $composableBuilder(
      column: $table.otpVerified, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tin => $composableBuilder(
      column: $table.tin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get changePassword => $composableBuilder(
      column: $table.changePassword,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get qrLink => $composableBuilder(
      column: $table.qrLink, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get merchantNumber => $composableBuilder(
      column: $table.merchantNumber,
      builder: (column) => ColumnFilters(column));
}

class $$MerchantsTableOrderingComposer
    extends Composer<_$DriftPlatformDatabase, $MerchantsTable> {
  $$MerchantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mechantCode => $composableBuilder(
      column: $table.mechantCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get identificationNumber => $composableBuilder(
      column: $table.identificationNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get licenceNumber => $composableBuilder(
      column: $table.licenceNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get documentReferenceId => $composableBuilder(
      column: $table.documentReferenceId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get agentId => $composableBuilder(
      column: $table.agentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get otp => $composableBuilder(
      column: $table.otp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get comments => $composableBuilder(
      column: $table.comments, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get otpVerified => $composableBuilder(
      column: $table.otpVerified, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tin => $composableBuilder(
      column: $table.tin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get changePassword => $composableBuilder(
      column: $table.changePassword,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get qrLink => $composableBuilder(
      column: $table.qrLink, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get merchantNumber => $composableBuilder(
      column: $table.merchantNumber,
      builder: (column) => ColumnOrderings(column));
}

class $$MerchantsTableAnnotationComposer
    extends Composer<_$DriftPlatformDatabase, $MerchantsTable> {
  $$MerchantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mechantCode => $composableBuilder(
      column: $table.mechantCode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get identificationNumber => $composableBuilder(
      column: $table.identificationNumber, builder: (column) => column);

  GeneratedColumn<String> get licenceNumber => $composableBuilder(
      column: $table.licenceNumber, builder: (column) => column);

  GeneratedColumn<String> get documentReferenceId => $composableBuilder(
      column: $table.documentReferenceId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get agentId =>
      $composableBuilder(column: $table.agentId, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get otp =>
      $composableBuilder(column: $table.otp, builder: (column) => column);

  GeneratedColumn<String> get comments =>
      $composableBuilder(column: $table.comments, builder: (column) => column);

  GeneratedColumn<String> get otpVerified => $composableBuilder(
      column: $table.otpVerified, builder: (column) => column);

  GeneratedColumn<String> get tin =>
      $composableBuilder(column: $table.tin, builder: (column) => column);

  GeneratedColumn<String> get changePassword => $composableBuilder(
      column: $table.changePassword, builder: (column) => column);

  GeneratedColumn<String> get qrLink =>
      $composableBuilder(column: $table.qrLink, builder: (column) => column);

  GeneratedColumn<String> get merchantNumber => $composableBuilder(
      column: $table.merchantNumber, builder: (column) => column);
}

class $$MerchantsTableTableManager extends RootTableManager<
    _$DriftPlatformDatabase,
    $MerchantsTable,
    Merchant,
    $$MerchantsTableFilterComposer,
    $$MerchantsTableOrderingComposer,
    $$MerchantsTableAnnotationComposer,
    $$MerchantsTableCreateCompanionBuilder,
    $$MerchantsTableUpdateCompanionBuilder,
    (
      Merchant,
      BaseReferences<_$DriftPlatformDatabase, $MerchantsTable, Merchant>
    ),
    Merchant,
    PrefetchHooks Function()> {
  $$MerchantsTableTableManager(
      _$DriftPlatformDatabase db, $MerchantsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MerchantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MerchantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MerchantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> mechantCode = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> phone = const Value.absent(),
            Value<String> password = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String> identificationNumber = const Value.absent(),
            Value<String?> licenceNumber = const Value.absent(),
            Value<String> documentReferenceId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> agentId = const Value.absent(),
            Value<int?> userId = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
            Value<String?> otp = const Value.absent(),
            Value<String?> comments = const Value.absent(),
            Value<String?> otpVerified = const Value.absent(),
            Value<String?> tin = const Value.absent(),
            Value<String?> changePassword = const Value.absent(),
            Value<String> qrLink = const Value.absent(),
            Value<String?> merchantNumber = const Value.absent(),
          }) =>
              MerchantsCompanion(
            id: id,
            mechantCode: mechantCode,
            name: name,
            phone: phone,
            password: password,
            email: email,
            identificationNumber: identificationNumber,
            licenceNumber: licenceNumber,
            documentReferenceId: documentReferenceId,
            status: status,
            agentId: agentId,
            userId: userId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            otp: otp,
            comments: comments,
            otpVerified: otpVerified,
            tin: tin,
            changePassword: changePassword,
            qrLink: qrLink,
            merchantNumber: merchantNumber,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String mechantCode,
            required String name,
            required String phone,
            required String password,
            Value<String?> email = const Value.absent(),
            required String identificationNumber,
            Value<String?> licenceNumber = const Value.absent(),
            required String documentReferenceId,
            Value<String> status = const Value.absent(),
            Value<int?> agentId = const Value.absent(),
            Value<int?> userId = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
            Value<String?> otp = const Value.absent(),
            Value<String?> comments = const Value.absent(),
            Value<String?> otpVerified = const Value.absent(),
            Value<String?> tin = const Value.absent(),
            Value<String?> changePassword = const Value.absent(),
            Value<String> qrLink = const Value.absent(),
            Value<String?> merchantNumber = const Value.absent(),
          }) =>
              MerchantsCompanion.insert(
            id: id,
            mechantCode: mechantCode,
            name: name,
            phone: phone,
            password: password,
            email: email,
            identificationNumber: identificationNumber,
            licenceNumber: licenceNumber,
            documentReferenceId: documentReferenceId,
            status: status,
            agentId: agentId,
            userId: userId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            otp: otp,
            comments: comments,
            otpVerified: otpVerified,
            tin: tin,
            changePassword: changePassword,
            qrLink: qrLink,
            merchantNumber: merchantNumber,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MerchantsTableProcessedTableManager = ProcessedTableManager<
    _$DriftPlatformDatabase,
    $MerchantsTable,
    Merchant,
    $$MerchantsTableFilterComposer,
    $$MerchantsTableOrderingComposer,
    $$MerchantsTableAnnotationComposer,
    $$MerchantsTableCreateCompanionBuilder,
    $$MerchantsTableUpdateCompanionBuilder,
    (
      Merchant,
      BaseReferences<_$DriftPlatformDatabase, $MerchantsTable, Merchant>
    ),
    Merchant,
    PrefetchHooks Function()>;
typedef $$BalancesTableCreateCompanionBuilder = BalancesCompanion Function({
  Value<int> id,
  required String userId,
  Value<String?> amount,
  Value<DateTime> date,
});
typedef $$BalancesTableUpdateCompanionBuilder = BalancesCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<String?> amount,
  Value<DateTime> date,
});

class $$BalancesTableFilterComposer
    extends Composer<_$DriftPlatformDatabase, $BalancesTable> {
  $$BalancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));
}

class $$BalancesTableOrderingComposer
    extends Composer<_$DriftPlatformDatabase, $BalancesTable> {
  $$BalancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));
}

class $$BalancesTableAnnotationComposer
    extends Composer<_$DriftPlatformDatabase, $BalancesTable> {
  $$BalancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$BalancesTableTableManager extends RootTableManager<
    _$DriftPlatformDatabase,
    $BalancesTable,
    Balance,
    $$BalancesTableFilterComposer,
    $$BalancesTableOrderingComposer,
    $$BalancesTableAnnotationComposer,
    $$BalancesTableCreateCompanionBuilder,
    $$BalancesTableUpdateCompanionBuilder,
    (Balance, BaseReferences<_$DriftPlatformDatabase, $BalancesTable, Balance>),
    Balance,
    PrefetchHooks Function()> {
  $$BalancesTableTableManager(_$DriftPlatformDatabase db, $BalancesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BalancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BalancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BalancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String?> amount = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
          }) =>
              BalancesCompanion(
            id: id,
            userId: userId,
            amount: amount,
            date: date,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            Value<String?> amount = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
          }) =>
              BalancesCompanion.insert(
            id: id,
            userId: userId,
            amount: amount,
            date: date,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BalancesTableProcessedTableManager = ProcessedTableManager<
    _$DriftPlatformDatabase,
    $BalancesTable,
    Balance,
    $$BalancesTableFilterComposer,
    $$BalancesTableOrderingComposer,
    $$BalancesTableAnnotationComposer,
    $$BalancesTableCreateCompanionBuilder,
    $$BalancesTableUpdateCompanionBuilder,
    (Balance, BaseReferences<_$DriftPlatformDatabase, $BalancesTable, Balance>),
    Balance,
    PrefetchHooks Function()>;
typedef $$CustomersTableCreateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String?> phone,
  Value<String?> identificationNumber,
  Value<String?> email,
  Value<String?> username,
  Value<String?> password,
  Value<String?> status,
  Value<String?> createdAt,
  Value<String?> updatedAt,
  Value<String?> otp,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String?> phone,
  Value<String?> identificationNumber,
  Value<String?> email,
  Value<String?> username,
  Value<String?> password,
  Value<String?> status,
  Value<String?> createdAt,
  Value<String?> updatedAt,
  Value<String?> otp,
});

class $$CustomersTableFilterComposer
    extends Composer<_$DriftPlatformDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get identificationNumber => $composableBuilder(
      column: $table.identificationNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get otp => $composableBuilder(
      column: $table.otp, builder: (column) => ColumnFilters(column));
}

class $$CustomersTableOrderingComposer
    extends Composer<_$DriftPlatformDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get identificationNumber => $composableBuilder(
      column: $table.identificationNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get otp => $composableBuilder(
      column: $table.otp, builder: (column) => ColumnOrderings(column));
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$DriftPlatformDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get identificationNumber => $composableBuilder(
      column: $table.identificationNumber, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get otp =>
      $composableBuilder(column: $table.otp, builder: (column) => column);
}

class $$CustomersTableTableManager extends RootTableManager<
    _$DriftPlatformDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableAnnotationComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder,
    (
      Customer,
      BaseReferences<_$DriftPlatformDatabase, $CustomersTable, Customer>
    ),
    Customer,
    PrefetchHooks Function()> {
  $$CustomersTableTableManager(
      _$DriftPlatformDatabase db, $CustomersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> identificationNumber = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> password = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
            Value<String?> otp = const Value.absent(),
          }) =>
              CustomersCompanion(
            id: id,
            name: name,
            phone: phone,
            identificationNumber: identificationNumber,
            email: email,
            username: username,
            password: password,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            otp: otp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> identificationNumber = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> password = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
            Value<String?> otp = const Value.absent(),
          }) =>
              CustomersCompanion.insert(
            id: id,
            name: name,
            phone: phone,
            identificationNumber: identificationNumber,
            email: email,
            username: username,
            password: password,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            otp: otp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CustomersTableProcessedTableManager = ProcessedTableManager<
    _$DriftPlatformDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableAnnotationComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder,
    (
      Customer,
      BaseReferences<_$DriftPlatformDatabase, $CustomersTable, Customer>
    ),
    Customer,
    PrefetchHooks Function()>;
typedef $$AccountSetupsTableCreateCompanionBuilder = AccountSetupsCompanion
    Function({
  Value<int> id,
  Value<String?> userId,
  Value<String?> accountNumber,
  Value<String?> paymentType,
  Value<String?> selectedBank,
});
typedef $$AccountSetupsTableUpdateCompanionBuilder = AccountSetupsCompanion
    Function({
  Value<int> id,
  Value<String?> userId,
  Value<String?> accountNumber,
  Value<String?> paymentType,
  Value<String?> selectedBank,
});

class $$AccountSetupsTableFilterComposer
    extends Composer<_$DriftPlatformDatabase, $AccountSetupsTable> {
  $$AccountSetupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountNumber => $composableBuilder(
      column: $table.accountNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selectedBank => $composableBuilder(
      column: $table.selectedBank, builder: (column) => ColumnFilters(column));
}

class $$AccountSetupsTableOrderingComposer
    extends Composer<_$DriftPlatformDatabase, $AccountSetupsTable> {
  $$AccountSetupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountNumber => $composableBuilder(
      column: $table.accountNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selectedBank => $composableBuilder(
      column: $table.selectedBank,
      builder: (column) => ColumnOrderings(column));
}

class $$AccountSetupsTableAnnotationComposer
    extends Composer<_$DriftPlatformDatabase, $AccountSetupsTable> {
  $$AccountSetupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get accountNumber => $composableBuilder(
      column: $table.accountNumber, builder: (column) => column);

  GeneratedColumn<String> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => column);

  GeneratedColumn<String> get selectedBank => $composableBuilder(
      column: $table.selectedBank, builder: (column) => column);
}

class $$AccountSetupsTableTableManager extends RootTableManager<
    _$DriftPlatformDatabase,
    $AccountSetupsTable,
    AccountSetup,
    $$AccountSetupsTableFilterComposer,
    $$AccountSetupsTableOrderingComposer,
    $$AccountSetupsTableAnnotationComposer,
    $$AccountSetupsTableCreateCompanionBuilder,
    $$AccountSetupsTableUpdateCompanionBuilder,
    (
      AccountSetup,
      BaseReferences<_$DriftPlatformDatabase, $AccountSetupsTable, AccountSetup>
    ),
    AccountSetup,
    PrefetchHooks Function()> {
  $$AccountSetupsTableTableManager(
      _$DriftPlatformDatabase db, $AccountSetupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountSetupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountSetupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountSetupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String?> accountNumber = const Value.absent(),
            Value<String?> paymentType = const Value.absent(),
            Value<String?> selectedBank = const Value.absent(),
          }) =>
              AccountSetupsCompanion(
            id: id,
            userId: userId,
            accountNumber: accountNumber,
            paymentType: paymentType,
            selectedBank: selectedBank,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String?> accountNumber = const Value.absent(),
            Value<String?> paymentType = const Value.absent(),
            Value<String?> selectedBank = const Value.absent(),
          }) =>
              AccountSetupsCompanion.insert(
            id: id,
            userId: userId,
            accountNumber: accountNumber,
            paymentType: paymentType,
            selectedBank: selectedBank,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AccountSetupsTableProcessedTableManager = ProcessedTableManager<
    _$DriftPlatformDatabase,
    $AccountSetupsTable,
    AccountSetup,
    $$AccountSetupsTableFilterComposer,
    $$AccountSetupsTableOrderingComposer,
    $$AccountSetupsTableAnnotationComposer,
    $$AccountSetupsTableCreateCompanionBuilder,
    $$AccountSetupsTableUpdateCompanionBuilder,
    (
      AccountSetup,
      BaseReferences<_$DriftPlatformDatabase, $AccountSetupsTable, AccountSetup>
    ),
    AccountSetup,
    PrefetchHooks Function()>;
typedef $$StatusTableCreateCompanionBuilder = StatusCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> createdAt,
  Value<String?> updatedAt,
});
typedef $$StatusTableUpdateCompanionBuilder = StatusCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> createdAt,
  Value<String?> updatedAt,
});

class $$StatusTableFilterComposer
    extends Composer<_$DriftPlatformDatabase, $StatusTable> {
  $$StatusTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$StatusTableOrderingComposer
    extends Composer<_$DriftPlatformDatabase, $StatusTable> {
  $$StatusTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$StatusTableAnnotationComposer
    extends Composer<_$DriftPlatformDatabase, $StatusTable> {
  $$StatusTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StatusTableTableManager extends RootTableManager<
    _$DriftPlatformDatabase,
    $StatusTable,
    StatusData,
    $$StatusTableFilterComposer,
    $$StatusTableOrderingComposer,
    $$StatusTableAnnotationComposer,
    $$StatusTableCreateCompanionBuilder,
    $$StatusTableUpdateCompanionBuilder,
    (
      StatusData,
      BaseReferences<_$DriftPlatformDatabase, $StatusTable, StatusData>
    ),
    StatusData,
    PrefetchHooks Function()> {
  $$StatusTableTableManager(_$DriftPlatformDatabase db, $StatusTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StatusTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StatusTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StatusTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
          }) =>
              StatusCompanion(
            id: id,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
          }) =>
              StatusCompanion.insert(
            id: id,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StatusTableProcessedTableManager = ProcessedTableManager<
    _$DriftPlatformDatabase,
    $StatusTable,
    StatusData,
    $$StatusTableFilterComposer,
    $$StatusTableOrderingComposer,
    $$StatusTableAnnotationComposer,
    $$StatusTableCreateCompanionBuilder,
    $$StatusTableUpdateCompanionBuilder,
    (
      StatusData,
      BaseReferences<_$DriftPlatformDatabase, $StatusTable, StatusData>
    ),
    StatusData,
    PrefetchHooks Function()>;
typedef $$TransactionsTableCreateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  Value<String?> date,
  Value<int?> paymentMethod,
  Value<String?> paymentGateway,
  Value<String?> transactionId,
  Value<int?> feesAssignChildrenId,
  Value<int?> feesCollectBy,
  Value<int?> studentId,
  Value<int?> sessionId,
  Value<String?> amount,
  Value<String?> fineAmount,
  Value<int?> accountId,
  Value<String?> comments,
  Value<int?> printed,
  Value<String?> createdAt,
  Value<String?> updatedAt,
});
typedef $$TransactionsTableUpdateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  Value<String?> date,
  Value<int?> paymentMethod,
  Value<String?> paymentGateway,
  Value<String?> transactionId,
  Value<int?> feesAssignChildrenId,
  Value<int?> feesCollectBy,
  Value<int?> studentId,
  Value<int?> sessionId,
  Value<String?> amount,
  Value<String?> fineAmount,
  Value<int?> accountId,
  Value<String?> comments,
  Value<int?> printed,
  Value<String?> createdAt,
  Value<String?> updatedAt,
});

class $$TransactionsTableFilterComposer
    extends Composer<_$DriftPlatformDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentGateway => $composableBuilder(
      column: $table.paymentGateway,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transactionId => $composableBuilder(
      column: $table.transactionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get feesAssignChildrenId => $composableBuilder(
      column: $table.feesAssignChildrenId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get feesCollectBy => $composableBuilder(
      column: $table.feesCollectBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get studentId => $composableBuilder(
      column: $table.studentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fineAmount => $composableBuilder(
      column: $table.fineAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get comments => $composableBuilder(
      column: $table.comments, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get printed => $composableBuilder(
      column: $table.printed, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$DriftPlatformDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentGateway => $composableBuilder(
      column: $table.paymentGateway,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transactionId => $composableBuilder(
      column: $table.transactionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get feesAssignChildrenId => $composableBuilder(
      column: $table.feesAssignChildrenId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get feesCollectBy => $composableBuilder(
      column: $table.feesCollectBy,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get studentId => $composableBuilder(
      column: $table.studentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fineAmount => $composableBuilder(
      column: $table.fineAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get comments => $composableBuilder(
      column: $table.comments, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get printed => $composableBuilder(
      column: $table.printed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$DriftPlatformDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<String> get paymentGateway => $composableBuilder(
      column: $table.paymentGateway, builder: (column) => column);

  GeneratedColumn<String> get transactionId => $composableBuilder(
      column: $table.transactionId, builder: (column) => column);

  GeneratedColumn<int> get feesAssignChildrenId => $composableBuilder(
      column: $table.feesAssignChildrenId, builder: (column) => column);

  GeneratedColumn<int> get feesCollectBy => $composableBuilder(
      column: $table.feesCollectBy, builder: (column) => column);

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<int> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get fineAmount => $composableBuilder(
      column: $table.fineAmount, builder: (column) => column);

  GeneratedColumn<int> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get comments =>
      $composableBuilder(column: $table.comments, builder: (column) => column);

  GeneratedColumn<int> get printed =>
      $composableBuilder(column: $table.printed, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TransactionsTableTableManager extends RootTableManager<
    _$DriftPlatformDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (
      Transaction,
      BaseReferences<_$DriftPlatformDatabase, $TransactionsTable, Transaction>
    ),
    Transaction,
    PrefetchHooks Function()> {
  $$TransactionsTableTableManager(
      _$DriftPlatformDatabase db, $TransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> date = const Value.absent(),
            Value<int?> paymentMethod = const Value.absent(),
            Value<String?> paymentGateway = const Value.absent(),
            Value<String?> transactionId = const Value.absent(),
            Value<int?> feesAssignChildrenId = const Value.absent(),
            Value<int?> feesCollectBy = const Value.absent(),
            Value<int?> studentId = const Value.absent(),
            Value<int?> sessionId = const Value.absent(),
            Value<String?> amount = const Value.absent(),
            Value<String?> fineAmount = const Value.absent(),
            Value<int?> accountId = const Value.absent(),
            Value<String?> comments = const Value.absent(),
            Value<int?> printed = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
          }) =>
              TransactionsCompanion(
            id: id,
            date: date,
            paymentMethod: paymentMethod,
            paymentGateway: paymentGateway,
            transactionId: transactionId,
            feesAssignChildrenId: feesAssignChildrenId,
            feesCollectBy: feesCollectBy,
            studentId: studentId,
            sessionId: sessionId,
            amount: amount,
            fineAmount: fineAmount,
            accountId: accountId,
            comments: comments,
            printed: printed,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> date = const Value.absent(),
            Value<int?> paymentMethod = const Value.absent(),
            Value<String?> paymentGateway = const Value.absent(),
            Value<String?> transactionId = const Value.absent(),
            Value<int?> feesAssignChildrenId = const Value.absent(),
            Value<int?> feesCollectBy = const Value.absent(),
            Value<int?> studentId = const Value.absent(),
            Value<int?> sessionId = const Value.absent(),
            Value<String?> amount = const Value.absent(),
            Value<String?> fineAmount = const Value.absent(),
            Value<int?> accountId = const Value.absent(),
            Value<String?> comments = const Value.absent(),
            Value<int?> printed = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
          }) =>
              TransactionsCompanion.insert(
            id: id,
            date: date,
            paymentMethod: paymentMethod,
            paymentGateway: paymentGateway,
            transactionId: transactionId,
            feesAssignChildrenId: feesAssignChildrenId,
            feesCollectBy: feesCollectBy,
            studentId: studentId,
            sessionId: sessionId,
            amount: amount,
            fineAmount: fineAmount,
            accountId: accountId,
            comments: comments,
            printed: printed,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TransactionsTableProcessedTableManager = ProcessedTableManager<
    _$DriftPlatformDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (
      Transaction,
      BaseReferences<_$DriftPlatformDatabase, $TransactionsTable, Transaction>
    ),
    Transaction,
    PrefetchHooks Function()>;
typedef $$AgentCommissionsTableCreateCompanionBuilder
    = AgentCommissionsCompanion Function({
  Value<int> id,
  required String totalAmount,
  required String totalTransactions,
  required String merchantId,
});
typedef $$AgentCommissionsTableUpdateCompanionBuilder
    = AgentCommissionsCompanion Function({
  Value<int> id,
  Value<String> totalAmount,
  Value<String> totalTransactions,
  Value<String> merchantId,
});

class $$AgentCommissionsTableFilterComposer
    extends Composer<_$DriftPlatformDatabase, $AgentCommissionsTable> {
  $$AgentCommissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get totalTransactions => $composableBuilder(
      column: $table.totalTransactions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get merchantId => $composableBuilder(
      column: $table.merchantId, builder: (column) => ColumnFilters(column));
}

class $$AgentCommissionsTableOrderingComposer
    extends Composer<_$DriftPlatformDatabase, $AgentCommissionsTable> {
  $$AgentCommissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get totalTransactions => $composableBuilder(
      column: $table.totalTransactions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get merchantId => $composableBuilder(
      column: $table.merchantId, builder: (column) => ColumnOrderings(column));
}

class $$AgentCommissionsTableAnnotationComposer
    extends Composer<_$DriftPlatformDatabase, $AgentCommissionsTable> {
  $$AgentCommissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => column);

  GeneratedColumn<String> get totalTransactions => $composableBuilder(
      column: $table.totalTransactions, builder: (column) => column);

  GeneratedColumn<String> get merchantId => $composableBuilder(
      column: $table.merchantId, builder: (column) => column);
}

class $$AgentCommissionsTableTableManager extends RootTableManager<
    _$DriftPlatformDatabase,
    $AgentCommissionsTable,
    AgentCommission,
    $$AgentCommissionsTableFilterComposer,
    $$AgentCommissionsTableOrderingComposer,
    $$AgentCommissionsTableAnnotationComposer,
    $$AgentCommissionsTableCreateCompanionBuilder,
    $$AgentCommissionsTableUpdateCompanionBuilder,
    (
      AgentCommission,
      BaseReferences<_$DriftPlatformDatabase, $AgentCommissionsTable,
          AgentCommission>
    ),
    AgentCommission,
    PrefetchHooks Function()> {
  $$AgentCommissionsTableTableManager(
      _$DriftPlatformDatabase db, $AgentCommissionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgentCommissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgentCommissionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgentCommissionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> totalAmount = const Value.absent(),
            Value<String> totalTransactions = const Value.absent(),
            Value<String> merchantId = const Value.absent(),
          }) =>
              AgentCommissionsCompanion(
            id: id,
            totalAmount: totalAmount,
            totalTransactions: totalTransactions,
            merchantId: merchantId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String totalAmount,
            required String totalTransactions,
            required String merchantId,
          }) =>
              AgentCommissionsCompanion.insert(
            id: id,
            totalAmount: totalAmount,
            totalTransactions: totalTransactions,
            merchantId: merchantId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AgentCommissionsTableProcessedTableManager = ProcessedTableManager<
    _$DriftPlatformDatabase,
    $AgentCommissionsTable,
    AgentCommission,
    $$AgentCommissionsTableFilterComposer,
    $$AgentCommissionsTableOrderingComposer,
    $$AgentCommissionsTableAnnotationComposer,
    $$AgentCommissionsTableCreateCompanionBuilder,
    $$AgentCommissionsTableUpdateCompanionBuilder,
    (
      AgentCommission,
      BaseReferences<_$DriftPlatformDatabase, $AgentCommissionsTable,
          AgentCommission>
    ),
    AgentCommission,
    PrefetchHooks Function()>;
typedef $$PaymentTransactionsTableCreateCompanionBuilder
    = PaymentTransactionsCompanion Function({
  Value<int> id,
  Value<String?> msisdn,
  Value<double?> amount,
  Value<String?> reference,
  Value<String?> type,
  Value<String?> status,
  Value<int?> mechantId,
  Value<String?> settlementStatus,
  Value<String?> charge,
  Value<String?> receivingAccountId,
  Value<String?> totalAmount,
  Value<String?> transactionId,
  Value<String?> settlementId,
  Value<String?> settlementDate,
  Value<String?> settlementAccount,
  Value<String?> settlementType,
  Value<String?> agentId,
  Value<String?> createdAt,
  Value<String?> updatedAt,
  Value<String?> callbackReceivedAt,
  Value<String?> callbackData,
});
typedef $$PaymentTransactionsTableUpdateCompanionBuilder
    = PaymentTransactionsCompanion Function({
  Value<int> id,
  Value<String?> msisdn,
  Value<double?> amount,
  Value<String?> reference,
  Value<String?> type,
  Value<String?> status,
  Value<int?> mechantId,
  Value<String?> settlementStatus,
  Value<String?> charge,
  Value<String?> receivingAccountId,
  Value<String?> totalAmount,
  Value<String?> transactionId,
  Value<String?> settlementId,
  Value<String?> settlementDate,
  Value<String?> settlementAccount,
  Value<String?> settlementType,
  Value<String?> agentId,
  Value<String?> createdAt,
  Value<String?> updatedAt,
  Value<String?> callbackReceivedAt,
  Value<String?> callbackData,
});

class $$PaymentTransactionsTableFilterComposer
    extends Composer<_$DriftPlatformDatabase, $PaymentTransactionsTable> {
  $$PaymentTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get msisdn => $composableBuilder(
      column: $table.msisdn, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mechantId => $composableBuilder(
      column: $table.mechantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get settlementStatus => $composableBuilder(
      column: $table.settlementStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get charge => $composableBuilder(
      column: $table.charge, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get receivingAccountId => $composableBuilder(
      column: $table.receivingAccountId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transactionId => $composableBuilder(
      column: $table.transactionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get settlementId => $composableBuilder(
      column: $table.settlementId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get settlementDate => $composableBuilder(
      column: $table.settlementDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get settlementAccount => $composableBuilder(
      column: $table.settlementAccount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get settlementType => $composableBuilder(
      column: $table.settlementType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get agentId => $composableBuilder(
      column: $table.agentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get callbackReceivedAt => $composableBuilder(
      column: $table.callbackReceivedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get callbackData => $composableBuilder(
      column: $table.callbackData, builder: (column) => ColumnFilters(column));
}

class $$PaymentTransactionsTableOrderingComposer
    extends Composer<_$DriftPlatformDatabase, $PaymentTransactionsTable> {
  $$PaymentTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get msisdn => $composableBuilder(
      column: $table.msisdn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mechantId => $composableBuilder(
      column: $table.mechantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get settlementStatus => $composableBuilder(
      column: $table.settlementStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get charge => $composableBuilder(
      column: $table.charge, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get receivingAccountId => $composableBuilder(
      column: $table.receivingAccountId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transactionId => $composableBuilder(
      column: $table.transactionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get settlementId => $composableBuilder(
      column: $table.settlementId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get settlementDate => $composableBuilder(
      column: $table.settlementDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get settlementAccount => $composableBuilder(
      column: $table.settlementAccount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get settlementType => $composableBuilder(
      column: $table.settlementType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get agentId => $composableBuilder(
      column: $table.agentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get callbackReceivedAt => $composableBuilder(
      column: $table.callbackReceivedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get callbackData => $composableBuilder(
      column: $table.callbackData,
      builder: (column) => ColumnOrderings(column));
}

class $$PaymentTransactionsTableAnnotationComposer
    extends Composer<_$DriftPlatformDatabase, $PaymentTransactionsTable> {
  $$PaymentTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get msisdn =>
      $composableBuilder(column: $table.msisdn, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get mechantId =>
      $composableBuilder(column: $table.mechantId, builder: (column) => column);

  GeneratedColumn<String> get settlementStatus => $composableBuilder(
      column: $table.settlementStatus, builder: (column) => column);

  GeneratedColumn<String> get charge =>
      $composableBuilder(column: $table.charge, builder: (column) => column);

  GeneratedColumn<String> get receivingAccountId => $composableBuilder(
      column: $table.receivingAccountId, builder: (column) => column);

  GeneratedColumn<String> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => column);

  GeneratedColumn<String> get transactionId => $composableBuilder(
      column: $table.transactionId, builder: (column) => column);

  GeneratedColumn<String> get settlementId => $composableBuilder(
      column: $table.settlementId, builder: (column) => column);

  GeneratedColumn<String> get settlementDate => $composableBuilder(
      column: $table.settlementDate, builder: (column) => column);

  GeneratedColumn<String> get settlementAccount => $composableBuilder(
      column: $table.settlementAccount, builder: (column) => column);

  GeneratedColumn<String> get settlementType => $composableBuilder(
      column: $table.settlementType, builder: (column) => column);

  GeneratedColumn<String> get agentId =>
      $composableBuilder(column: $table.agentId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get callbackReceivedAt => $composableBuilder(
      column: $table.callbackReceivedAt, builder: (column) => column);

  GeneratedColumn<String> get callbackData => $composableBuilder(
      column: $table.callbackData, builder: (column) => column);
}

class $$PaymentTransactionsTableTableManager extends RootTableManager<
    _$DriftPlatformDatabase,
    $PaymentTransactionsTable,
    PaymentTransaction,
    $$PaymentTransactionsTableFilterComposer,
    $$PaymentTransactionsTableOrderingComposer,
    $$PaymentTransactionsTableAnnotationComposer,
    $$PaymentTransactionsTableCreateCompanionBuilder,
    $$PaymentTransactionsTableUpdateCompanionBuilder,
    (
      PaymentTransaction,
      BaseReferences<_$DriftPlatformDatabase, $PaymentTransactionsTable,
          PaymentTransaction>
    ),
    PaymentTransaction,
    PrefetchHooks Function()> {
  $$PaymentTransactionsTableTableManager(
      _$DriftPlatformDatabase db, $PaymentTransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentTransactionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentTransactionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> msisdn = const Value.absent(),
            Value<double?> amount = const Value.absent(),
            Value<String?> reference = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<int?> mechantId = const Value.absent(),
            Value<String?> settlementStatus = const Value.absent(),
            Value<String?> charge = const Value.absent(),
            Value<String?> receivingAccountId = const Value.absent(),
            Value<String?> totalAmount = const Value.absent(),
            Value<String?> transactionId = const Value.absent(),
            Value<String?> settlementId = const Value.absent(),
            Value<String?> settlementDate = const Value.absent(),
            Value<String?> settlementAccount = const Value.absent(),
            Value<String?> settlementType = const Value.absent(),
            Value<String?> agentId = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
            Value<String?> callbackReceivedAt = const Value.absent(),
            Value<String?> callbackData = const Value.absent(),
          }) =>
              PaymentTransactionsCompanion(
            id: id,
            msisdn: msisdn,
            amount: amount,
            reference: reference,
            type: type,
            status: status,
            mechantId: mechantId,
            settlementStatus: settlementStatus,
            charge: charge,
            receivingAccountId: receivingAccountId,
            totalAmount: totalAmount,
            transactionId: transactionId,
            settlementId: settlementId,
            settlementDate: settlementDate,
            settlementAccount: settlementAccount,
            settlementType: settlementType,
            agentId: agentId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            callbackReceivedAt: callbackReceivedAt,
            callbackData: callbackData,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> msisdn = const Value.absent(),
            Value<double?> amount = const Value.absent(),
            Value<String?> reference = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<int?> mechantId = const Value.absent(),
            Value<String?> settlementStatus = const Value.absent(),
            Value<String?> charge = const Value.absent(),
            Value<String?> receivingAccountId = const Value.absent(),
            Value<String?> totalAmount = const Value.absent(),
            Value<String?> transactionId = const Value.absent(),
            Value<String?> settlementId = const Value.absent(),
            Value<String?> settlementDate = const Value.absent(),
            Value<String?> settlementAccount = const Value.absent(),
            Value<String?> settlementType = const Value.absent(),
            Value<String?> agentId = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> updatedAt = const Value.absent(),
            Value<String?> callbackReceivedAt = const Value.absent(),
            Value<String?> callbackData = const Value.absent(),
          }) =>
              PaymentTransactionsCompanion.insert(
            id: id,
            msisdn: msisdn,
            amount: amount,
            reference: reference,
            type: type,
            status: status,
            mechantId: mechantId,
            settlementStatus: settlementStatus,
            charge: charge,
            receivingAccountId: receivingAccountId,
            totalAmount: totalAmount,
            transactionId: transactionId,
            settlementId: settlementId,
            settlementDate: settlementDate,
            settlementAccount: settlementAccount,
            settlementType: settlementType,
            agentId: agentId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            callbackReceivedAt: callbackReceivedAt,
            callbackData: callbackData,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PaymentTransactionsTableProcessedTableManager = ProcessedTableManager<
    _$DriftPlatformDatabase,
    $PaymentTransactionsTable,
    PaymentTransaction,
    $$PaymentTransactionsTableFilterComposer,
    $$PaymentTransactionsTableOrderingComposer,
    $$PaymentTransactionsTableAnnotationComposer,
    $$PaymentTransactionsTableCreateCompanionBuilder,
    $$PaymentTransactionsTableUpdateCompanionBuilder,
    (
      PaymentTransaction,
      BaseReferences<_$DriftPlatformDatabase, $PaymentTransactionsTable,
          PaymentTransaction>
    ),
    PaymentTransaction,
    PrefetchHooks Function()>;

class $DriftPlatformDatabaseManager {
  final _$DriftPlatformDatabase _db;
  $DriftPlatformDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$MerchantsTableTableManager get merchants =>
      $$MerchantsTableTableManager(_db, _db.merchants);
  $$BalancesTableTableManager get balances =>
      $$BalancesTableTableManager(_db, _db.balances);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$AccountSetupsTableTableManager get accountSetups =>
      $$AccountSetupsTableTableManager(_db, _db.accountSetups);
  $$StatusTableTableManager get status =>
      $$StatusTableTableManager(_db, _db.status);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$AgentCommissionsTableTableManager get agentCommissions =>
      $$AgentCommissionsTableTableManager(_db, _db.agentCommissions);
  $$PaymentTransactionsTableTableManager get paymentTransactions =>
      $$PaymentTransactionsTableTableManager(_db, _db.paymentTransactions);
}
