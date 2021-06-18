class TodoService {
  Map<String, dynamic> roles;

  TodoService(this.roles);

  bool matchingRoles(List<String> allowedRoles) {
    for(int i = 0; i < allowedRoles.length; i++)
      if (roles.containsKey(allowedRoles[i]) && roles[allowedRoles[i]]) return true;
    return false;
  }

  bool canDelete() {
    var allowedRoles = ['admin'];
    return matchingRoles(allowedRoles);
  }

  bool canEdit() {
    var allowedRoles = ['admin', 'manager'];
    return matchingRoles(allowedRoles);
  }
}