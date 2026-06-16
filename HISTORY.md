# HISTORY

## 2026-06-17

- Deprecated Flutter APIs were replaced: `withOpacity`, `ColorScheme.background`, and `Matrix4.translate`.

## 2026-06-16

- 단어 조합 전체 조회 usecase와 단어 표시 정보 resolver를 추가했습니다.
- presentation 계층에서 단어 데이터 레지스트리를 직접 참조하던 중복 조회 로직을 정리했습니다.
- 주요 팝업/힌트/기본 단어 문구를 `AppStrings`로 이동하고 상수 네이밍을 lowerCamelCase로 정리했습니다.

## 2026-06-13

- AGENTS.md를 git 추적 대상에서 제외하도록 `.gitignore`에 추가했습니다.
- 로컬 작업 지침 파일은 유지하면서 저장소에는 포함되지 않도록 정리했습니다.
