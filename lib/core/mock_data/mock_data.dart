import 'package:jihagz/core/supabase_model/profiles.dart';
import 'package:jihagz/core/supabase_model/sports_clubs_verified.dart';

class MockData {
  static const String demoUserId = 'demo-user-id';

  static Profile get demoProfile => Profile(
        id: demoUserId,
        email: 'demo@jihagz.app',
        name: 'Axon',
        phone: '+201223237666',
        gender: 'Male',
        age: 19,
        points: 60,
        profile_image:
            'https://cdn-icons-png.flaticon.com/512/847/847969.png',
        createdAt: '2025-07-01T10:30:25.689541+00:00',
      );

  static const Map<int, int> demoRatingDistribution = {
    1: 0,
    2: 1,
    3: 2,
    4: 5,
    5: 8,
  };

  static List<Map<String, dynamic>> _allStadiumsJson() => [
        {
          'id': 'mock-fadi-field',
          'name': 'ملعب فادي',
          'type': 'football',
          'latitude': '31.2152417',
          'longitude': '29.9255200',
          'rate': '4.7',
          'number_rated': '24',
          'price': '250 جنيه / ساعة',
          'phone_number': '01099476230',
          'images': [
            'https://images.unsplash.com/photo-1529900748604-07564a03e7a6?auto=format&fit=crop&w=800&q=80',
            'https://images.unsplash.com/photo-1574629810360-7efbbe195018?auto=format&fit=crop&w=800&q=80',
          ],
          'created_at': '2025-07-05T14:51:33.316173+00:00',
          'added_by': demoUserId,
          'distance': 0.8,
        },
        {
          'id': '3e32e740-01ed-46ce-b612-85baf6d6c038',
          'name': 'ملعب نادي سيدي بشر الرياضي',
          'type': 'football',
          'latitude': '31.257637931952836',
          'longitude': '29.982638222012536',
          'rate': '4.0',
          'number_rated': '18',
          'price': '200 جنيه / ساعة',
          'phone_number': '01099476230',
          'images': [
            'https://res.cloudinary.com/dnzs6jkya/image/upload/v1751727089/public/n2jbstqhtzcgssusarvq.jpg',
            'https://res.cloudinary.com/dnzs6jkya/image/upload/v1751727091/public/nvnzkjcjfehqckv47zmt.jpg',
          ],
          'created_at': '2025-07-05T14:51:33.316173+00:00',
          'added_by': demoUserId,
          'distance': 1.4,
        },
        {
          'id': 'af55c402-f92e-41e3-9078-16289892c448',
          'name': 'ملعب طلائع الاسطول',
          'type': 'football',
          'latitude': '31.202031259857737',
          'longitude': '29.870683840175637',
          'rate': '5.0',
          'number_rated': '32',
          'price': '300 جنيه / ساعة',
          'phone_number': '01005551234',
          'images': [
            'https://res.cloudinary.com/dnzs6jkya/image/upload/v1751821607/public/mpl6uilow7kcmw3abv7n.jpg',
            'https://res.cloudinary.com/dnzs6jkya/image/upload/v1751821608/public/ymwwnxzwudgnfp4xieyv.jpg',
            'https://res.cloudinary.com/dnzs6jkya/image/upload/v1751821609/public/o1f5zya6smxdozdlurmu.jpg',
          ],
          'created_at': '2025-07-06T17:06:52.508339+00:00',
          'added_by': demoUserId,
          'distance': 2.1,
        },
        {
          'id': 'mock-smouha-field',
          'name': 'ملعب سموحة',
          'type': 'football',
          'latitude': '31.2159000',
          'longitude': '29.9550000',
          'rate': '4.3',
          'number_rated': '15',
          'price': '180 جنيه / ساعة',
          'phone_number': '01006667890',
          'images': [
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
          ],
          'created_at': '2025-07-07T07:22:06.109231+00:00',
          'added_by': demoUserId,
          'distance': 3.0,
        },
        {
          'id': 'mock-padel-pro',
          'name': 'Padel Pro - Asafra',
          'type': 'padel',
          'latitude': '31.2400000',
          'longitude': '29.9700000',
          'rate': '4.6',
          'number_rated': '11',
          'price': '350 جنيه / ساعة',
          'phone_number': '01007771234',
          'images': [
            'https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=800&q=80',
          ],
          'created_at': '2025-07-08T10:00:00.000000+00:00',
          'added_by': demoUserId,
          'distance': 1.8,
        },
        {
          'id': 'mock-padel-alex',
          'name': 'Alex Padel Club',
          'type': 'padel',
          'latitude': '31.2300000',
          'longitude': '29.9400000',
          'rate': '4.2',
          'number_rated': '9',
          'price': '320 جنيه / ساعة',
          'phone_number': '01008881234',
          'images': [
            'https://images.unsplash.com/photo-1554068865-24cecd4e34b8?auto=format&fit=crop&w=800&q=80',
          ],
          'created_at': '2025-07-08T11:00:00.000000+00:00',
          'added_by': demoUserId,
          'distance': 2.5,
        },
        {
          'id': 'mock-tennis-sidi',
          'name': 'Tennis Club - Sidi Bishr',
          'type': 'tennis',
          'latitude': '31.2600000',
          'longitude': '29.9800000',
          'rate': '4.8',
          'number_rated': '20',
          'price': '280 جنيه / ساعة',
          'phone_number': '01009991234',
          'images': [
            'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=800&q=80',
          ],
          'created_at': '2025-07-08T12:00:00.000000+00:00',
          'added_by': demoUserId,
          'distance': 1.6,
        },
        {
          'id': 'mock-tennis-stanley',
          'name': 'Stanley Tennis Courts',
          'type': 'tennis',
          'latitude': '31.2450000',
          'longitude': '29.9650000',
          'rate': '4.4',
          'number_rated': '14',
          'price': '260 جنيه / ساعة',
          'phone_number': '01001112222',
          'images': [
            'https://images.unsplash.com/photo-1622163640701-1a2a049a4b8f?auto=format&fit=crop&w=800&q=80',
          ],
          'created_at': '2025-07-08T13:00:00.000000+00:00',
          'added_by': demoUserId,
          'distance': 2.9,
        },
      ];

  static List<SportsClubsVerified> getStadiumsForCategory(String category) {
    final type = category.toLowerCase();
    return _allStadiumsJson()
        .where((item) => item['type'] == type)
        .map(SportsClubsVerified.fromJson)
        .toList();
  }

  static List<Map<String, dynamic>> getStadiumMapsForCategory(
    String category,
  ) {
    final type = category.toLowerCase();
    return _allStadiumsJson()
        .where((item) => item['type'] == type)
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  static List<SportsClubsVerified> getNearbyStadiums(
    List<SportsClubsVerified> stadiums, {
    int count = 3,
  }) {
    final sorted = List<SportsClubsVerified>.from(stadiums)
      ..sort((a, b) => a.distance.compareTo(b.distance));
    return sorted.take(count).toList();
  }
}
