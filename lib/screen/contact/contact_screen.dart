import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:html' as html;

import '../../component/header/header.dart';
import '../../component/header/header_drawer.dart';
import '../../responsive.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late final String hintText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isNarrowWidth(context)
          ? ShortHeader(
          automaticallyImplyLeading: false
      )
          : AfterLoginHeader(
        automaticallyImplyLeading: false,
        context: context,
      ),
      drawer: Responsive.isNarrowWidth(context)
          ? AfterLoginHeaderDrawer()
          : null,
      body: _contactPageUI(),
    );
  }

  //컨택트 페이지 UI
  Widget _contactPageUI() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 120),
            child: _contactSubtitleTextUI('문의하기'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 120),
            child: Column(
              children: [
                _buildContactFormField(1, '사용자 이름'),
                _buildContactFormField(1, '사용자 이메일'),
                _buildContactFormField(1, '제목'),
                _buildContactFormField(5, '문의 내용', maxLength: 100),
                SizedBox(height: 16),
                _sendBtnUI(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 120),
            child: _contactSubtitleTextUI('찾아오시는 길'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '서울특별시 종로구 창경궁로 254',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5,),
                _mapUI(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _contactSubtitleTextUI('SNS'),
                SizedBox(height: 10),
                _snsRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //서브 타이틀 텍스트
  Widget _contactSubtitleTextUI(String subtitle) {
    return Text(
      subtitle,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  //문의 양식 입력란
  Widget _buildContactFormField(int maxLines, String hintText, {int? maxLength}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        inputFormatters: [
          if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
        ],
      ),
    );
  }

  //전송 버튼
  Widget _sendBtnUI() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: pointColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: Text('보내기'),
      ),
    );
  }

  //지도
  Widget _mapUI() {
    final screenWidth = MediaQuery.of(context).size.width;
    final markerPosition = const LatLng(37.583883601891, 126.9999880311);
    final Marker marker = Marker(
      markerId: const MarkerId('initial_marker'),
      position: markerPosition,
      infoWindow: const InfoWindow(
        title: '서울특별시 종로구 창경궁로 254',
      ),
    );
    return Container(
      height: 250,
      width: screenWidth,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(37.583883601891, 126.9999880311),
            zoom: 12,
          ),
          markers: {marker},
        ),
      ),
    );
  }

  //sns 아이콘 버튼들
  Widget _snsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _instagramBtn(),
        _facebookBtn(),
        _twitterBtn(),
      ],
    );
  }

  //instagram 버튼
  Widget _instagramBtn() {
    return  Column(
      children: [
        IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {
            String url = 'https://instagram.com';
            _launchURL(url);
          },
        ),
        Text('instagram'),
      ],
    );
  }

  //facebook 버튼
  Widget _facebookBtn() {
    return Column(
      children: [
        IconButton(
          icon: Icon(Icons.facebook),
          onPressed: () {
            String url = 'https://facebook.com';
            _launchURL(url);
          },
        ),
        Text('facebook'),
      ],
    );
  }

  //twitter 버튼
  Widget _twitterBtn() {
    return Column(
      children: [
        IconButton(
          icon: Icon(Icons.alternate_email),
          onPressed: () {
            String url = 'https://x.com/';
            _launchURL(url);
          },
        ),
        Text('twitter'),
      ],
    );
  }

  //URL 열기
  void _launchURL(String url) {
    try {
      html.window.open(url, '_blank');
    } catch (e) {
      print('Error: $e');
    }
  }
}