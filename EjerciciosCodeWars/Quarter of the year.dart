int quarter(int month) {
  if ([1, 2, 3].contains(month)) return 1;
  if ([4, 5, 6].contains(month)) return 2;
  if ([7, 8, 9].contains(month)) return 3;
  return 4;
}
