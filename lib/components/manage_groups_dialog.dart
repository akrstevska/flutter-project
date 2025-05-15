import 'package:flutter/material.dart';
import '../utilities/birthday_group.dart';
import '../utilities/birthday_group_data.dart';
import '../utilities/constants.dart';

class ManageGroupsDialog extends StatefulWidget {
  @override
  State<ManageGroupsDialog> createState() => _ManageGroupsDialogState();
}

class _ManageGroupsDialogState extends State<ManageGroupsDialog> {
  List<BirthdayGroup> groups = [];

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    await loadBirthdayGroups();
    setState(() {
      groups = groupList;
    });
  }

  void _showAutoDismissDialog({
    required String title,
    required String message,
    required Color textColor,
    Duration duration = const Duration(seconds: 2),
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Constants.blackPrimary,
        title: Text(title, style: TextStyle(color: textColor)),
        content: Text(
          message,
          style: TextStyle(color: Constants.greyPrimary),
        ),
      ),
    );

    Future.delayed(duration, () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }

  void _editGroup(BirthdayGroup group) async {
    final nameController = TextEditingController(text: group.name);
    final emailController = TextEditingController(text: group.email ?? '');
    String? nameError;

    await showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: Constants.blackPrimary,
            title: Text("Edit Group", style: TextStyle(color: Constants.whiteSecondary)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  style: TextStyle(color: Constants.whiteSecondary),
                  decoration: InputDecoration(
                    labelText: 'Group Name *',
                    labelStyle: TextStyle(color: Constants.greyPrimary),
                    errorText: nameError,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Constants.greySecondary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Constants.purpleSecondary),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  style: TextStyle(color: Constants.whiteSecondary),
                  decoration: InputDecoration(
                    labelText: 'Group Email',
                    labelStyle: TextStyle(color: Constants.greyPrimary),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Constants.greySecondary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Constants.purpleSecondary),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text("Save"),
                onPressed: () async {
                  final trimmedName = nameController.text.trim();

                  if (trimmedName.isEmpty) {
                    setState(() {
                      nameError = "Group name cannot be empty.";
                    });
                    return;
                  }

                  Navigator.pop(context);
                  final updated = BirthdayGroup(
                    id: group.id,
                    name: trimmedName,
                    email: emailController.text.isEmpty ? null : emailController.text,
                    birthdays: group.birthdays,
                    settings: group.settings,
                  );
                  await updateBirthdayGroup(updated);
                  await _loadGroups();
                  _showAutoDismissDialog(
                    title: "Success",
                    message: "Group updated successfully!",
                    textColor: Colors.green,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }


  void _deleteGroup(BirthdayGroup group) async {
    final errorMessage = await deleteBirthdayGroup(group.id);

    if (errorMessage != null) {
      _showAutoDismissDialog(
        title: "Delete Failed",
        message: errorMessage,
        textColor: Colors.red,
      );
    } else {
      await _loadGroups();
      _showAutoDismissDialog(
        title: "Deleted",
        message: "Group deleted successfully!",
        textColor: Colors.green,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Constants.blackPrimary,
      title: Center(
        child: Text(
          "Manage Birthday Groups",
          style: TextStyle(
            color: Constants.purpleSecondary,
            fontSize: Constants.titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: groups.isEmpty
            ? const Center(child: CircularProgressIndicator(color: Constants.purpleSecondary))
            : ListView.builder(
          shrinkWrap: true,
          itemCount: groups.length,
          itemBuilder: (context, index) {
            final group = groups[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Constants.darkGreySecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(
                  group.name,
                  style: TextStyle(
                    color: Constants.whiteSecondary,
                    fontSize: Constants.biggerFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  group.email ?? 'No email provided',
                  style: TextStyle(color: Constants.greyPrimary),
                ),
                trailing: SizedBox(
                  width: 96,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.orangeAccent,
                        onPressed: () => _editGroup(group),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.redAccent,
                        onPressed: () => _deleteGroup(group),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close", style: TextStyle(color: Constants.whiteSecondary)),
          ),
        ),
      ],
    );
  }
}
