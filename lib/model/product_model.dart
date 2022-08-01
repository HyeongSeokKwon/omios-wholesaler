class Product {
  int id;
  int price;
  String name;
  String mainImage;

  Product({
    required this.id,
    required this.price,
    required this.name,
    required this.mainImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: json['price'],
      name: json['name'],
      mainImage: json['main_image'],
    );
  }
}

class CategoryInfoModel {
  final String mainCategory;
  final List<OptionInfoModel> subCategory;

  CategoryInfoModel({
    required this.mainCategory,
    required this.subCategory,
  });

  factory CategoryInfoModel.fromJson(Map<String, dynamic> json) {
    return CategoryInfoModel(
      mainCategory: json['name'],
      subCategory: List.generate(
        json['items'].length,
        (index) => OptionInfoModel.fromJson(
          json['items'][index],
        ),
      ),
    );
  }
}

class ColorInfoModel {
  final int id;
  final String name;
  final String imageUrl;

  ColorInfoModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory ColorInfoModel.fromJson(Map<String, dynamic> json) {
    return ColorInfoModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}

class SizeInfoModel {
  final String name;
  final List<OptionInfoModel> items;

  SizeInfoModel({
    required this.name,
    required this.items,
  });

  factory SizeInfoModel.fromJson(Map<String, dynamic> json) {
    return SizeInfoModel(
      name: json['name'],
      items: List.generate(
        json['items'].length,
        (index) => OptionInfoModel.fromJson(json['items'][index]),
      ),
    );
  }
}

class AdditionalInfoModel {
  final AdditionalInfoItemsModel thickness;
  final AdditionalInfoItemsModel seethrough;
  final AdditionalInfoItemsModel flexibility;
  final AdditionalInfoItemsModel lining;

  AdditionalInfoModel({
    required this.thickness,
    required this.seethrough,
    required this.flexibility,
    required this.lining,
  });

  factory AdditionalInfoModel.fromJson(Map<String, dynamic> json) {
    return AdditionalInfoModel(
      thickness: AdditionalInfoItemsModel.fromJson(json['thickness']),
      seethrough: AdditionalInfoItemsModel.fromJson(json['see_through']),
      flexibility: AdditionalInfoItemsModel.fromJson(json['flexibility']),
      lining: AdditionalInfoItemsModel.fromJson(json['lining']),
    );
  }
}

class AdditionalInfoItemsModel {
  final String name;
  final List<OptionInfoModel> items;

  AdditionalInfoItemsModel({
    required this.name,
    required this.items,
  });

  factory AdditionalInfoItemsModel.fromJson(Map<String, dynamic> json) {
    return AdditionalInfoItemsModel(
      name: json['name'],
      items: List.generate(json['items'].length,
          (index) => OptionInfoModel.fromJson(json['items'][index])),
    );
  }
}

class LaundryInfoModel {
  final int id;
  final String name;

  LaundryInfoModel({
    required this.id,
    required this.name,
  });

  factory LaundryInfoModel.fromJson(Map<String, dynamic> json) {
    return LaundryInfoModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class StyleInfoModel {
  final int id;
  final String name;

  StyleInfoModel({
    required this.id,
    required this.name,
  });

  factory StyleInfoModel.fromJson(Map<String, dynamic> json) {
    return StyleInfoModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class TargetAgeGroupInfoModel {
  final int id;
  final String name;

  TargetAgeGroupInfoModel({
    required this.id,
    required this.name,
  });

  factory TargetAgeGroupInfoModel.fromJson(Map<String, dynamic> json) {
    return TargetAgeGroupInfoModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class OptionInfoModel {
  final int id;
  final String name;

  OptionInfoModel({
    required this.id,
    required this.name,
  });

  factory OptionInfoModel.fromJson(Map<String, dynamic> json) {
    return OptionInfoModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

//regist data itmes's value들 체크후 형식 비슷하면 클래스 하나로 묶어서 items's value 처리
Map data = {
  "code": 200,
  "message": "success",
  "data": {
    "category": [
      {
        "name": "아우터",
        "items": [
          {"id": 1, "name": "가디건"},
          {"id": 2, "name": "자켓"},
          {"id": 3, "name": "점퍼"},
          {"id": 4, "name": "코트"},
          {"id": 5, "name": "패딩"},
          {"id": 6, "name": "바람막이"},
          {"id": 7, "name": "야상"},
          {"id": 8, "name": "커플 아우터"}
        ]
      },
      {
        "name": "상의",
        "items": [
          {"id": 9, "name": "티셔츠"},
          {"id": 10, "name": "니트/스웨터"},
          {"id": 11, "name": "셔츠/남방"},
          {"id": 12, "name": "맨투맨"},
          {"id": 13, "name": "후드"},
          {"id": 14, "name": "블라우스"},
          {"id": 15, "name": "민소매/나시"},
          {"id": 16, "name": "조끼"},
          {"id": 17, "name": "커플 상의"}
        ]
      },
      {
        "name": "원피스/세트",
        "items": [
          {"id": 18, "name": "미니원피스"},
          {"id": 19, "name": "미디원피스"},
          {"id": 20, "name": "롱원피스"},
          {"id": 21, "name": "투피스/세트"},
          {"id": 22, "name": "점프수트"}
        ]
      },
      {
        "name": "바지",
        "items": [
          {"id": 23, "name": "일자바지"},
          {"id": 24, "name": "슬랙스팬츠"},
          {"id": 25, "name": "숏팬츠"},
          {"id": 26, "name": "와이드팬츠"},
          {"id": 27, "name": "스키니팬츠"},
          {"id": 28, "name": "부츠컷팬츠"},
          {"id": 29, "name": "조거팬츠"},
          {"id": 30, "name": "데님"},
          {"id": 31, "name": "반바지"},
          {"id": 32, "name": "치마바지"},
          {"id": 33, "name": "멜빵바지"},
          {"id": 34, "name": "크롭팬츠"},
          {"id": 35, "name": "배기팬츠"},
          {"id": 36, "name": "레깅스"}
        ]
      },
      {
        "name": "스커트",
        "items": [
          {"id": 37, "name": "미니스커트"},
          {"id": 38, "name": "미디스커트"},
          {"id": 39, "name": "롱스커트"}
        ]
      },
      {
        "name": "트레이닝복",
        "items": [
          {"id": 40, "name": "트레이닝 세트"},
          {"id": 41, "name": "트레이닝 상의"},
          {"id": 42, "name": "트레이닝 하의"}
        ]
      },
      {
        "name": "비치웨어",
        "items": [
          {"id": 43, "name": "비키니"},
          {"id": 44, "name": "모노키니"},
          {"id": 45, "name": "래쉬가드"},
          {"id": 46, "name": "원피스 수영복"},
          {"id": 47, "name": "비치상의"},
          {"id": 48, "name": "비치하의"},
          {"id": 49, "name": "커플웨어"},
          {"id": 50, "name": "비치 액서서리"}
        ]
      },
      {
        "name": "란제리/파자마",
        "items": [
          {"id": 51, "name": "파자마/홈웨어"},
          {"id": 52, "name": "브라"},
          {"id": 53, "name": "팬티"},
          {"id": 54, "name": "속옷 세트"},
          {"id": 55, "name": "속바지"}
        ]
      },
      {
        "name": "신발",
        "items": [
          {"id": 56, "name": "플랫/로퍼"},
          {"id": 57, "name": "힐/펌프스"},
          {"id": 58, "name": "웨지힐"},
          {"id": 59, "name": "샌들/슬리퍼/쪼리"},
          {"id": 60, "name": "스니커즈/운동화"},
          {"id": 61, "name": "워크/부츠"},
          {"id": 62, "name": "수제화"}
        ]
      },
      {
        "name": "액세서리",
        "items": [
          {"id": 63, "name": "목걸이"},
          {"id": 64, "name": "반지"},
          {"id": 65, "name": "양말"},
          {"id": 66, "name": "모자"},
          {"id": 67, "name": "선글라스/안경"},
          {"id": 68, "name": "타이즈/스타킹"},
          {"id": 69, "name": "스카프/머플러"},
          {"id": 70, "name": "시계"},
          {"id": 71, "name": "벨트"},
          {"id": 72, "name": "장갑"},
          {"id": 73, "name": "헤어 액세서리"},
          {"id": 74, "name": "네일 스티커"},
          {"id": 75, "name": "핸드폰"}
        ]
      },
      {
        "name": "가방",
        "items": [
          {"id": 76, "name": "숄더백"},
          {"id": 77, "name": "크로스백"},
          {"id": 78, "name": "토트백"},
          {"id": 79, "name": "클러치"},
          {"id": 80, "name": "미니백"},
          {"id": 81, "name": "백팩"},
          {"id": 82, "name": "에코백"},
          {"id": 83, "name": "파우치"},
          {"id": 84, "name": "지갑"}
        ]
      },
      {
        "name": "main_category_1",
        "items": [
          {"id": 85, "name": "sub_category_1"}
        ]
      }
    ],
    "color": [
      {
        "id": 1,
        "name": "블랙",
        "image_url":
            "https://deepy.s3.ap-northeast-2.amazonaws.com/static/client/color/black.svg"
      },
      {
        "id": 2,
        "name": "화이트",
        "image_url":
            "https://deepy.s3.ap-northeast-2.amazonaws.com/static/client/color/white.svg"
      },
      {
        "id": 3,
        "name": "브라운",
        "image_url":
            "https://deepy.s3.ap-northeast-2.amazonaws.com/static/client/color/brown.svg"
      },
      {
        "id": 4,
        "name": "베이지",
        "image_url":
            "https://deepy.s3.ap-northeast-2.amazonaws.com/static/client/color/beige.svg"
      },
      {
        "id": 5,
        "name": "남색",
        "image_url":
            "https://deepy.s3.ap-northeast-2.amazonaws.com/static/client/color/indigo.svg"
      },
      {
        "id": 6,
        "name": "네이비",
        "image_url":
            "https://deepy.s3.ap-northeast-2.amazonaws.com/static/client/color/navy.svg"
      },
      {
        "id": 7,
        "name": "옐로우",
        "image_url":
            "https://deepy.s3.ap-northeast-2.amazonaws.com/static/client/color/yellow.svg"
      },
      {
        "id": 8,
        "name": "레드",
        "image_url":
            "https://deepy.s3.ap-northeast-2.amazonaws.com/static/client/color/red.svg"
      },
      {
        "id": 9,
        "name": "초록",
        "image_url":
            "https://deepy.s3.ap-northeast-2.amazonaws.com/static/client/color/green.svg"
      },
      {
        "id": 10,
        "name": "블루",
        "image_url":
            "https://deepy.s3.ap-northeast-2.amazonaws.com/static/client/color/blue.svg"
      },
      {
        "id": 11,
        "name": "카키",
        "image_url":
            "https://deepy.s3.ap-northeast-2.amazonaws.com/static/client/color/khaki.svg"
      },
      {
        "id": 12,
        "name": "핑크",
        "image_url":
            "https://deepy.s3.ap-northeast-2.amazonaws.com/static/client/color/pink.svg"
      }
    ],
    "size": [
      {
        "name": "FREE",
        "items": [
          {"id": 1, "name": "FREE"}
        ]
      },
      {
        "name": "일반(2XS~4XL)",
        "items": [
          {"id": 2, "name": "2XS"},
          {"id": 3, "name": "XS"},
          {"id": 4, "name": "S"},
          {"id": 5, "name": "M"},
          {"id": 6, "name": "L"},
          {"id": 7, "name": "XL"},
          {"id": 8, "name": "2XL"},
          {"id": 9, "name": "3XL"},
          {"id": 10, "name": "4XL"}
        ]
      },
      {
        "name": "상의1(33~99, 11단위)",
        "items": [
          {"id": 11, "name": "33"},
          {"id": 12, "name": "44"},
          {"id": 13, "name": "55"},
          {"id": 14, "name": "66"},
          {"id": 15, "name": "77"},
          {"id": 16, "name": "88"},
          {"id": 17, "name": "99"}
        ]
      },
      {
        "name": "상의2(80~120, 5단위)",
        "items": [
          {"id": 18, "name": "80"},
          {"id": 19, "name": "85"},
          {"id": 20, "name": "90"},
          {"id": 21, "name": "95"},
          {"id": 22, "name": "100"},
          {"id": 23, "name": "105"},
          {"id": 24, "name": "110"},
          {"id": 25, "name": "115"},
          {"id": 26, "name": "120"}
        ]
      },
      {
        "name": "바지/치마(20인치~48인치)",
        "items": [
          {"id": 27, "name": "20인치"},
          {"id": 28, "name": "21인치"},
          {"id": 29, "name": "22인치"},
          {"id": 30, "name": "23인치"},
          {"id": 31, "name": "24인치"},
          {"id": 32, "name": "25인치"},
          {"id": 33, "name": "26인치"},
          {"id": 34, "name": "27인치"},
          {"id": 35, "name": "28인치"},
          {"id": 36, "name": "29인치"},
          {"id": 37, "name": "30인치"},
          {"id": 38, "name": "31인치"},
          {"id": 39, "name": "32인치"},
          {"id": 40, "name": "33인치"},
          {"id": 41, "name": "34인치"},
          {"id": 42, "name": "35인치"},
          {"id": 43, "name": "36인치"},
          {"id": 44, "name": "37인치"},
          {"id": 45, "name": "38인치"},
          {"id": 46, "name": "39인치"},
          {"id": 47, "name": "40인치"},
          {"id": 48, "name": "41인치"},
          {"id": 49, "name": "42인치"},
          {"id": 50, "name": "43인치"},
          {"id": 51, "name": "44인치"},
          {"id": 52, "name": "45인치"},
          {"id": 53, "name": "46인치"},
          {"id": 54, "name": "47인치"},
          {"id": 55, "name": "48인치"}
        ]
      },
      {
        "name": "신발(200mm~300mm, 5단위)",
        "items": [
          {"id": 56, "name": "200mm"},
          {"id": 57, "name": "205mm"},
          {"id": 58, "name": "210mm"},
          {"id": 59, "name": "215mm"},
          {"id": 60, "name": "220mm"},
          {"id": 61, "name": "225mm"},
          {"id": 62, "name": "230mm"},
          {"id": 63, "name": "235mm"},
          {"id": 64, "name": "240mm"},
          {"id": 65, "name": "245mm"},
          {"id": 66, "name": "250mm"},
          {"id": 67, "name": "255mm"},
          {"id": 68, "name": "260mm"},
          {"id": 69, "name": "265mm"},
          {"id": 70, "name": "270mm"},
          {"id": 71, "name": "275mm"},
          {"id": 72, "name": "280mm"},
          {"id": 73, "name": "285mm"},
          {"id": 74, "name": "290mm"},
          {"id": 75, "name": "295mm"},
          {"id": 76, "name": "300mm"}
        ]
      },
      {
        "name": "반지(1호~30호)",
        "items": [
          {"id": 77, "name": "1호"},
          {"id": 78, "name": "2호"},
          {"id": 79, "name": "3호"},
          {"id": 80, "name": "4호"},
          {"id": 81, "name": "5호"},
          {"id": 82, "name": "6호"},
          {"id": 83, "name": "7호"},
          {"id": 84, "name": "8호"},
          {"id": 85, "name": "9호"},
          {"id": 86, "name": "10호"},
          {"id": 87, "name": "11호"},
          {"id": 88, "name": "12호"},
          {"id": 89, "name": "13호"},
          {"id": 90, "name": "14호"},
          {"id": 91, "name": "15호"},
          {"id": 92, "name": "16호"},
          {"id": 93, "name": "17호"},
          {"id": 94, "name": "18호"},
          {"id": 95, "name": "19호"},
          {"id": 96, "name": "20호"},
          {"id": 97, "name": "21호"},
          {"id": 98, "name": "22호"},
          {"id": 99, "name": "23호"},
          {"id": 100, "name": "24호"},
          {"id": 101, "name": "25호"},
          {"id": 102, "name": "26호"},
          {"id": 103, "name": "27호"},
          {"id": 104, "name": "28호"},
          {"id": 105, "name": "29호"},
          {"id": 106, "name": "30호"}
        ]
      }
    ],
    "additional_information": {
      "thickness": {
        "name": "두께",
        "items": [
          {"id": 107, "name": "두꺼움"},
          {"id": 108, "name": "보통"},
          {"id": 109, "name": "얇음"}
        ]
      },
      "see_through": {
        "name": "비침",
        "items": [
          {"id": 110, "name": "있음"},
          {"id": 111, "name": "보통"},
          {"id": 112, "name": "없음"}
        ]
      },
      "flexibility": {
        "name": "신축성",
        "items": [
          {"id": 113, "name": "좋음"},
          {"id": 114, "name": "보통"},
          {"id": 115, "name": "없음"}
        ]
      },
      "lining": {
        "name": "안감",
        "items": [
          {"id": 116, "name": "있음"},
          {"id": 117, "name": "없음"},
          {"id": 118, "name": "기모안감"}
        ]
      }
    },
    "laundry_information": [
      {"id": 119, "name": "다림질 금지"},
      {"id": 120, "name": "단독세탁"},
      {"id": 121, "name": "드라이클리닝"},
      {"id": 122, "name": "물세탁"},
      {"id": 123, "name": "세탁기 금지"},
      {"id": 124, "name": "손세탁"},
      {"id": 125, "name": "울세탁"},
      {"id": 126, "name": "표백제 사용금지"}
    ],
    "style": [
      {"id": 127, "name": "로맨틱"},
      {"id": 128, "name": "시크"},
      {"id": 129, "name": "럭셔리"},
      {"id": 130, "name": "미시"},
      {"id": 131, "name": "마담"},
      {"id": 132, "name": "오피스"},
      {"id": 133, "name": "캐쥬얼"},
      {"id": 134, "name": "섹시"},
      {"id": 135, "name": "어반/모던"},
      {"id": 136, "name": "유니크"},
      {"id": 137, "name": "심플베이직"}
    ],
    "target_age_group": [
      {"id": 138, "name": "10대 이하"},
      {"id": 139, "name": "20대 초반 ~ 20대 중반"},
      {"id": 140, "name": "20대 중반 ~ 20대 후반"},
      {"id": 141, "name": "20대 후반 ~ 30대 초반"},
      {"id": 142, "name": "30대 초반 ~ 30대 중반"},
      {"id": 143, "name": "30대 중반 ~ 30대 후반"},
      {"id": 144, "name": "40대"},
      {"id": 145, "name": "50대 이상"}
    ]
  }
};


/* 

OptionInfoModel => {'id' : 'xx', 'name' : 'xx'} 형태를 클래스로

List<OptionInfoModel> 형태인 데이터
1. CategoryModel의 subCategory의 item들
2. Size의 item들
3. Addiionalinfo의 각 항목들의 item들
4. LaundryInfo, StyleInfo, TargetAgeGroup의 아이템들
*/