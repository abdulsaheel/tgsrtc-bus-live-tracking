import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamyam/data/models/city.dart';
import 'package:gamyam/data/models/bus_service.dart';
import 'package:gamyam/data/models/vehicle.dart';
import 'package:gamyam/data/models/live_data.dart';
import 'package:gamyam/data/models/stop.dart';
import 'package:gamyam/data/models/bus_trip.dart';
import 'package:gamyam/data/models/trip_detail.dart';

const samples = '../samples';
List _json(String f) => jsonDecode(File('$samples/$f').readAsStringSync()) as List;
Map<String,dynamic> _obj(String f) => jsonDecode(File('$samples/$f').readAsStringSync()) as Map<String,dynamic>;

void main() {
  test('City parses', () {
    final c = City.fromJson((_json('city.json').first) as Map<String,dynamic>);
    expect(c.name, isNotEmpty);
  });
  test('BusService parses (null routeNumber)', () {
    final s = BusService.fromJson(_json('services_v2.json').first as Map<String,dynamic>);
    expect(s.id, isPositive);
  });
  test('Vehicle parses', () {
    final v = Vehicle.fromJson(_json('vehicles_v2.json').first as Map<String,dynamic>);
    expect(v.registrationNumber, isNotNull);
  });
  test('LiveData parses + freshness helpers', () {
    final d = LiveData.fromJson(_obj('live_vehicle.json'));
    expect(d.latitude, closeTo(17.5, 1));
    expect(d.gpsTimestamp, isNotNull);
    expect(d.hasNoData, isTrue); // sample has statusStr "No Data"
  });
  test('BusTrip route-search parses (totalStops as int)', () {
    final t = BusTrip.fromJson(_json('route_search_v3.json').first as Map<String,dynamic>);
    expect(t.serviceName, '10H');
    expect(t.vehicleId, isPositive);
    expect(t.totalStops, 35);
    expect(t.from?.name, isNotEmpty);
    expect(t.to?.name, isNotEmpty);
  });
  test('TripDetail parses with polyline + stop coords', () {
    final d = TripDetail.fromJson(_obj('trip_detail.json'));
    expect(d.points.length, greaterThan(10));
    expect(d.polylinePoints.length, greaterThan(100));
    expect(d.points.first.latitude, isNotNull);
    expect(d.helpline, isNotNull);
  });
  test('BusSearchResponse (between) parses with timing', () {
    final r = BusSearchResponse.fromJson(_obj('between_v3.json'));
    expect(r.trips, isNotEmpty);
    final t = r.trips.first;
    expect(t.serviceType, isNotNull);
    expect(t.from?.name, isNotEmpty);
    expect(t.to?.name, isNotEmpty);
    // plannedTime present → travelMinutes computable (or null, never throws)
    final _ = t.travelMinutes;
    expect(t.isLive, isA<bool>());
  });
  test('Stop + NearbyStop parse', () {
    expect(Stop.fromJson(_json('stops_v3.json').first as Map<String,dynamic>).name, isNotEmpty);
    final n = NearbyStop.fromJson(_json('stops_nearby.json').first as Map<String,dynamic>);
    expect(n.latitude, isNotNull);
    expect(n.longitude, isNotNull);
  });
}
