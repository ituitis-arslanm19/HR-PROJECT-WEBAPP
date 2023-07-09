// ignore_for_file: constant_identifier_names

enum HttpMethod { GET, POST, PUT, DELETE }

enum DataState { LOADING, READY, ERROR, EMPTY }

enum ClientType { MANAGER, EMPLOYEE, HR, ADMIN }

enum TimeOffStatus { APPROVED, PENDING, DENIED, COMPLETED }

enum ProductType { LAPTOP, HEADPHONE, MOUSE, KEYBOARD, OTHER }

enum ProductStatus {
  RETURNED("İade edildi"),
  NOT_RETURNED("İade edilmedi"),
  AT_EMPLOYEE("Çalışanda");

  final String translation;

  @override
  String toString() {
    return translation;
  }

  const ProductStatus(this.translation);
}
