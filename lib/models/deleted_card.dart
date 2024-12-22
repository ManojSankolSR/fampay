import 'package:hive/hive.dart';

part 'deleted_card.g.dart'; 

@HiveType(typeId: 1) 
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
