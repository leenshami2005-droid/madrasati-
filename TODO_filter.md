# TODO: Add Nearby School Filtering (<10km)

## Steps:
- [x] 1. Update getlonglat.dart: Fix/improve location fetching (added static getCurrentPosition)
- [x] 2. Update findschools.dart: Await location, pass lat/long to nearschools (added userPosition, _getLocation, pass to nearschools, fixed typos)
- [x] 3. Update schoolsnearby.dart: Add constructor params, Haversine filter (with distance <10km)
- [ ] 4. Test: flutter run, grant location, verify filtered cards

Updated after each step.
