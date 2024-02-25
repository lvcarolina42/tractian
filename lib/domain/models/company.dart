enum CompanyEnum {
  apex,
  jaguar,
  tobias
}

class Company {
  final CompanyEnum companyEnum;
  final String name;
  final String path;

  Company({required this.companyEnum, required this.name, required this.path});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyEnum: json['companyEnum'],
      name: json['name'],
      path: json['path'],
    );
  }
}