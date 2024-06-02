import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmizania/colors.dart';
import 'package:lmizania/cubits/delete_goal_cubit/delete_goal_cubit.dart';
import 'package:lmizania/data/models/goal_model.dart';
import 'package:lmizania/update_states.dart';
import 'package:lmizania/utils/custom_text_field.dart';
import 'package:lmizania/utils/filter_row.dart';
import 'package:lmizania/utils/group_card.dart';
import 'package:lmizania/utils/group_settings_card.dart';
import 'package:lmizania/utils/input_section.dart';
import 'package:lmizania/utils/segment_button.dart';
import 'package:lmizania/utils/transaction_card.dart';
import 'package:lmizania/utils/transaction_section.dart';

class EditPersonalGoalScreen extends StatefulWidget {
  @override
  State<EditPersonalGoalScreen> createState() => _EditPersonalGoalScreenState();

  GoalModel goal;
  EditPersonalGoalScreen({required this.goal});
}

class _EditPersonalGoalScreenState extends State<EditPersonalGoalScreen> {
  late final TextEditingController goalNameController;
  late final TextEditingController goalPriceController;
  late final TextEditingController goalDescriptionController;
  @override
  void initState() {
    super.initState();
    goalNameController = TextEditingController(text: widget.goal.name);
    goalPriceController =
        TextEditingController(text: widget.goal.targetAmount.toString());
    goalDescriptionController =
        TextEditingController(text: widget.goal.description);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.bgColor,
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: Color(0xff00494C).withOpacity(0.95),
        title: Text(
          'Edit Goal',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: media.width * 0.82,
                width: media.width * 0.82,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(
                      "images/laptop.png",
                    ),
                    fit: BoxFit.fill,
                  ),
                  border: Border.all(
                    width: 2,
                    color: TColor.themeColor.withOpacity(0.5),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InputSection(
                inputTitle: "Goal name",
                hintText: "Write your goal name",
                controller: goalNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a goal name';
                  }
                  return null;
                },
              ),
              InputSection(
                inputTitle: "Goal price",
                hintText: "Write your goal price",
                keyboardType: TextInputType.numberWithOptions(),
                controller: goalPriceController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a goal price';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid integer';
                  }
                  return null;
                },
              ),
              InputSection(
                inputTitle: "Goal description",
                hintText: "Write your goal description",
                keyboardType: TextInputType.multiline,
                controller: goalDescriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a goal description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColor.themeColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black.withOpacity(0.25),
                                width: 1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          BlocProvider.of<DeleteGoalCubit>(context).deleteGoal(
                            id: widget.goal.id!,
                          );
                          await Future.delayed(Duration(milliseconds: 200));
                          updateGoalsScreen(context);
                          updateHomeScreen(context);

                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            Text(
                              "Delete",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black.withOpacity(0.25),
                                width: 1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
