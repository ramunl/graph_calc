import 'package:ordered_set/comparing.dart';
import 'package:ordered_set/ordered_set.dart';

import 'Point.dart';

class AdaptivePlot {
  final depth = 6;
  final eps = 0.005;
  final Function f;
  final num minX;
  final num maxX;
  final plot = OrderedSet<Point>(Comparing.on((p) => p.x));

  AdaptivePlot(this.f, this.minX, this.maxX);

  Point pointAt(num x) {
    return new Point(x, f(x));
  }

  AdaptivePlot computePlot() {
    plot.clear();
    Point pa = pointAt(minX);
    Point pc = pointAt(maxX);
    plot.add(pa);
    plot.add(pc);
    doComputePlot(pa, pc, depth, eps);
    return this;
  }

  void doComputePlot(Point pa, Point pc, int depth, num eps) {
    Point pb = pointAt(0.5 * (pa.x + pc.x));
    Point pa1 = pointAt(0.5 * (pa.x + pb.x));
    Point pb1 = pointAt(0.5 * (pb.x + pc.x));
    plot.add(pb);
    if (depth > 0 &&
        (oscillates(pa.y, pa1.y, pb.y, pb1.y, pc.y) ||
            unsmooth(pa.y, pa1.y, pb.y, pb1.y, pc.y, eps))) {
      doComputePlot(pa, pb, depth - 1, 2 * eps);
      doComputePlot(pb, pc, depth - 1, 2 * eps);
    }
    plot.add(pa1);
    plot.add(pb1);
  }

  bool oscillates(num ya, num ya1, num yb, num yb1, num yc) {
    return isOscillation(ya, ya1, yb) &&
        isOscillation(ya1, yb, yb1) &&
        isOscillation(yb, yb1, yc);
  }

  bool isOscillation(num ya, num yb, num yc) {
    return !ya.isFinite ||
        !yb.isFinite ||
        !yc.isFinite ||
        (yb > ya && yb > yc) ||
        (yb < ya && yb < yc);
  }

  num quadrature(num y0, num y1, num y2, {num y3}) {
    if (y3 != null) {
      return 3.0 / 8.0 * y0 +
          19.0 / 24.0 * y1 -
          5.0 / 24.0 * y2 +
          1.0 / 24.0 * y3;
    } else {
      return 5.0 / 12.0 * y0 + 2.0 / 3.0 * y1 - 1.0 / 12.0 * y2;
    }
  }

  bool unsmooth(num ya, num ya1, num yb, num yb1, num yc, num eps) {
    var y0 = [ya, ya1, yb, yb1, yc]
        .reduce((curr, next) => curr < next ? curr : next);
    var yg = [ya, ya1, yb, yb1, yc].map((y) => y - y0).toList();

    num q4 = quadrature(yg[0], yg[1], yg[2], y3: yg[3]);
    num q3 = quadrature(yg[2], yg[3], yg[4]);
    return (q4 - q3).abs() > eps * q3;
  }
}
