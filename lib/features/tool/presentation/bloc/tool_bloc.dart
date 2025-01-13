import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hastools/features/tool/data/models/tool_model/index.dart';
import 'package:hastools/features/tool/data/repositories/tool_repository_impl.dart';

part 'tool_bloc.freezed.dart';

@freezed
class ToolEvent with _$ToolEvent {
  const factory ToolEvent.loadTools() = LoadTools;
  const factory ToolEvent.incrementClick(String toolName) = IncrementClick;
  const factory ToolEvent.sortTools() = SortTools;
  const factory ToolEvent.resetTools() = ResetTools;
}

@freezed
class ToolState with _$ToolState {
  const factory ToolState.initial() = Initial;
  const factory ToolState.loading() = Loading;
  const factory ToolState.loaded(List<Tool> tools) = Loaded;
  const factory ToolState.error(String message) = Error;
}

class ToolBloc extends Bloc<ToolEvent, ToolState> {
  final ToolRepository repository;

  ToolBloc({required this.repository}) : super(const ToolState.initial()) {
    on<LoadTools>((event, emit) async {
      emit(const ToolState.loading());
      try {
        final tools = await repository.fetchTools();
        emit(ToolState.loaded(tools));
      } catch (e) {
        emit(ToolState.error('Failed to load tools'));
      }
    });
    on<ResetTools>((event, emit) async {
      emit(const ToolState.loading());
      try {
        await repository.resetTools();
        emit(const ToolState.initial());
        add(const ToolEvent.sortTools());
      } catch (e) {
        emit(ToolState.error('Failed to reset tools'));
      }
    });

    on<IncrementClick>((event, emit) async {
      if (state is Loaded) {
        final tools = (state as Loaded).tools;
        final updatedTools = tools.map((tool) {
          if (tool.name == event.toolName) {
            return tool.copyWith(clickCount: tool.clickCount + 1);
          }
          return tool;
        }).toList();

        await repository.saveTools(updatedTools);

        emit(ToolState.loaded(updatedTools));

        add(const ToolEvent.sortTools());
      }
    });

    on<SortTools>((event, emit) async {
      if (state is Loaded) {
        final tools = (state as Loaded).tools;
        final sortedTools = List.of(tools)
          ..sort((a, b) => b.clickCount.compareTo(a.clickCount));
        emit(ToolState.loaded(sortedTools));
      }
    });
  }
}
