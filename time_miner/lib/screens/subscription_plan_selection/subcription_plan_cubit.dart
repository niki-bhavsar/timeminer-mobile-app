import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/data/entity/subscription_plan_entiry.dart';

class SubscriptionPlanCubit extends Cubit<int> {
  SubscriptionPlanCubit() : super(1);

  final List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      title: 'TMT - Monthly',
      price: '\$24.99',
      desc: 'Perfect Plan for Starter',
      recommended: false,
    ),
    SubscriptionPlan(
      title: 'TMT - Annually',
      price: '\$239.88',
      desc: 'Best Value - 20% Discount',
      recommended: true,
    ),
    SubscriptionPlan(
      title: 'TMT - Quarterly',
      price: '\$67.47',
      desc: '10% discount over monthly',
      recommended: false,
    ),
  ];

  void selectPlan(int index) => emit(index);
}