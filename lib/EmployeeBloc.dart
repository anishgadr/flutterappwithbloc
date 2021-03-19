import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {
  List<Employee> _emplist = [
    Employee(1, "Emp One", 10000.0),
    Employee(2, "Emp Two", 20000.0),
    Employee(3, "Emp Thre", 15000.0),
    Employee(4, "Emp Four", 25000.0),
    Employee(4, "Emp Five", 25000.0)
  ];

  final _empliststreamcontroller = StreamController<List<Employee>>();

  final _empsalaryincsc = StreamController<Employee>();
  final _empsalarydecsc = StreamController<Employee>();

  Stream<List<Employee>> get empbloc => _empliststreamcontroller.stream;

  StreamSink<List<Employee>> get emplistsink => _empliststreamcontroller.sink;

  StreamSink<Employee> get empsalaryinc => _empsalaryincsc.sink;

  StreamSink<Employee> get empsalarydec => _empsalarydecsc.sink;

  EmployeeBloc() {
    _empliststreamcontroller.add(_emplist);
    _empsalaryincsc.stream.listen(_incsalry);
    _empsalarydecsc.stream.listen(_decsalry);
  }

  _incsalry(Employee employee) {
    double salary = employee.salary;
    double incrementSalry = salary * 20 / 100;
    _emplist[employee.id - 1].salary = salary + incrementSalry;
    emplistsink.add(_emplist);
  }

  _decsalry(Employee employee) {
    double salary = employee.salary;
    double decrementSalry = salary * 20 / 100;
    _emplist[employee.id - 1].salary = salary - decrementSalry;
    emplistsink.add(_emplist);
  }

  void dispose() {
    _empsalaryincsc.close();
    _empsalarydecsc.close();
    _empliststreamcontroller.close();
  }
}
