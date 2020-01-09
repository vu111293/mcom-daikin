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
