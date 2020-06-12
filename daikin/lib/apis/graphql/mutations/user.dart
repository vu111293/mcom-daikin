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
        permissions,
        unreadNotifyCount
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
      permissions,
      unreadNotifyCount
    }
  }
''';

String registerNotify = r'''
  mutation RegisterNoti($id: ID!, $deviceToken: String!) {
    registerNotify (_id: $id, deviceToken: $deviceToken){   
      _id,
      uid,
      fullName,
      phone,
      email,
      avatar, 
      role,
      permissions,
      deviceToken,
      unreadNotifyCount
    }
  }
''';

String unregisterNotify = r'''
  mutation UnregisterNoti($id: ID!) {
    unregisterNotify (_id: $id){   
      _id,
      uid,
      fullName,
      phone,
      email,
      avatar, 
      role,
      permissions,
      deviceToken,
      unreadNotifyCount
    }
  }
''';



