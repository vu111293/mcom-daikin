String login = r'''
  mutation Login($token: String!) {
    login (token: $token){   
      user{
        _id,
        uid,
        fullName,
        phone,
        email,
        avatar, 
        role,
        permissions
      }
      token
    }
  }
''';

String updateUser = r'''
  mutation UpdateUser($id: ID!, $fullName: String!, $email: String!, $avatar: String!) {
    updateUser (_id: $id, fullName: $fullName, email: $email, avatar: $avatar){   
      avatar,
      _id,
      fullName,
      phone,
      email,
      avatar,
      role,
      uid,
      permissions
    }
  }
''';
