class GraphQLQueryHelper {
  static const String getAllData = """
{
  post_getPublicHomePageFeed(take: 10, skip: 0, order: "DESC") {
    items {
      user_details {
        id
        first_name
        last_name
        profile_pic
        email
      }
    }
  }
}
  """;
}
