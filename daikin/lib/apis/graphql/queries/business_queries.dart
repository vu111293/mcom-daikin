
String me = r'''
  query getMe {
    me {
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



String notification = r'''
  query getNotifications {
    notifications(q:{sort: {status: -1, createdAt: -1}}) {
      data {
        _id,
        title,
        body,
        image,
        status
      }
    }
  }      
''';

String makeReadQuery = r'''
    query makeReaded($id: ID!){
      triggerNotification(_id: $id)
    }
''';
