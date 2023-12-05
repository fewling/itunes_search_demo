import 'package:freezed_annotation/freezed_annotation.dart';

part 'itune_response.freezed.dart';
part 'itune_response.g.dart';

@freezed
class ITuneResponse with _$ITuneResponse {
  const factory ITuneResponse({
    @Default(0) int resultCount,
    @Default(<ITuneResult>[]) List<ITuneResult> results,
  }) = _ITuneResponse;

  factory ITuneResponse.fromJson(Map<String, dynamic> json) =>
      _$ITuneResponseFromJson(json);
}

@freezed
class ITuneResult with _$ITuneResult {
  const factory ITuneResult({
    String? wrapperType,
    String? kind,
    int? artistId,
    int? collectionId,
    int? trackId,
    String? artistName,
    String? collectionName,
    String? trackName,
    String? collectionCensoredName,
    String? trackCensoredName,
    String? artistViewUrl,
    String? collectionViewUrl,
    String? trackViewUrl,
    String? previewUrl,
    String? artworkUrl30,
    String? artworkUrl60,
    String? artworkUrl100,
    double? collectionPrice,
    double? trackPrice,
    String? releaseDate,
    String? collectionExplicitness,
    String? trackExplicitness,
    int? discCount,
    int? discNumber,
    int? trackCount,
    int? trackNumber,
    int? trackTimeMillis,
    String? country,
    String? currency,
    String? primaryGenreName,
    bool? isStreamable,
  }) = _ITuneResult;

  factory ITuneResult.fromJson(Map<String, dynamic> json) =>
      _$ITuneResultFromJson(json);
}
