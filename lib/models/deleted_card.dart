import 'package:hive/hive.dart';

part 'deleted_card.g.dart'; // Generated part file for Hive adapter

@HiveType(typeId: 1) // Ensure a unique typeId for this class
class DeletedCard extends HiveObject {
  @HiveField(0)
  final String cardGroupId;

  @HiveField(1)
  final String cardId;

  @HiveField(2)
  final String slugId;

  DeletedCard({
    required this.cardGroupId,
    required this.cardId,
    required this.slugId,
  });
}
