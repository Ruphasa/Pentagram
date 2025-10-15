import 'package:flutter/material.dart';

IconData iconFromKey(String key) {
  switch (key) {
    case 'dashboard':
      return Icons.dashboard_outlined;
    case 'attach_money':
      return Icons.attach_money;
    case 'arrow_downward':
      return Icons.arrow_downward;
    case 'arrow_upward':
      return Icons.arrow_upward;
    case 'receipt_long':
      return Icons.receipt_long;
    case 'people':
      return Icons.people;
    case 'home_work':
      return Icons.home_work;
    case 'person_add':
      return Icons.person_add;
    case 'person_add_alt':
      return Icons.person_add_alt;
    case 'transfer_within_a_station':
      return Icons.transfer_within_a_station;
    case 'list_alt':
      return Icons.list_alt;
    case 'add':
      return Icons.add;
    case 'campaign':
      return Icons.campaign;
    case 'message':
      return Icons.message;
    case 'history':
      return Icons.history;
    case 'manage_accounts':
      return Icons.manage_accounts;
    case 'list':
      return Icons.list;
    case 'sync_alt':
      return Icons.sync_alt;
    case 'family_restroom':
      return Icons.family_restroom;
    case 'add_home':
      return Icons.add_home;
    case 'money_off':
      return Icons.money_off;
    case 'inbox':
      return Icons.inbox;
    case 'event':
      return Icons.event;
    default:
      return Icons.circle;
  }
}
