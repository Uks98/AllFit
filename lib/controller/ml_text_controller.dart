import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GetCounter extends GetxController{
  RxInt count = 0.obs;
  void upCount(double angleKnee, double angleHip) {
    const correctKneeRadian = 63.7;
    const correctHipRadian = 68.8;

    bool isTemperatureAHigh = angleKnee > correctKneeRadian;
    bool isTemperatureBHigh = angleHip > correctHipRadian;

    if (isTemperatureAHigh && isTemperatureBHigh) {
      count++;
    }
  }
}