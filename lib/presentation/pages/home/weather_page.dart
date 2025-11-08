import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_scutum_test/core/extensions/date_time_extension.dart';
import 'package:flutter_space_scutum_test/core/utils/constants.dart';
import 'package:flutter_space_scutum_test/presentation/blocs/weather/weather_bloc.dart';
import 'package:flutter_space_scutum_test/presentation/pages/common/dialogs/dialog_helper.dart';
import 'package:flutter_space_scutum_test/resources/app_colors.dart';
import 'package:flutter_space_scutum_test/resources/app_text_style.dart';
import 'package:flutter_space_scutum_test/widget/cached_network_image_widget.dart';
import 'package:flutter_space_scutum_test/widget/card/weather_card_widget.dart';
import 'package:flutter_space_scutum_test/widget/scaffold_widget.dart';

/// Weather screen displaying current weather information.
///
/// Responsibilities:
/// - trigger weather loading on page open
/// - show header with main weather data
/// - show secondary weather parameters (humidity, wind, pressure)
/// - display loading and error states
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();

    // Load weather once the first UI frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherBloc>().add(const WeatherLoadEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      /// Show error dialog if weather failed to load.
      listener: (context, state) async {
        if (state is WeatherErrorState) {
          await DialogHelper.showErrorDialog(context, message: 'Не вдалося завантажити дані');
        }
      },

      child: ScaffoldWidget(
        appBar: AppBar(
          backgroundColor: AppColors.colorGraphite,
          title: const Text('Погода', style: AppTextStyle.medium18),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.colorPureWhite),
        ),

        /// Main content of the page.
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            // Show loading for both loading and error (until retry)
            if (state is WeatherLoadingState || state is WeatherErrorState) {
              return const Center(child: CircularProgressIndicator());
            }

            // When successfully loaded, show weather content.
            return const _BodyWidget();
          },
        ),
      ),
    );
  }
}

/// Main content layout containing weather header and weather details widgets.
class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _WeatherHeader(),
          SizedBox(height: 14),
          Divider(color: AppColors.colorGraphiteLine),
          SizedBox(height: 20),
          _WeatherListWidget(),
        ],
      ),
    );
  }
}

/// Header displaying main weather information: icon, temperature, description,
/// city, country and measurement time.
class _WeatherHeader extends StatelessWidget {
  const _WeatherHeader();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<WeatherBloc>();
    final weather = bloc.state.weather;

    // Extract core weather values from domain.
    final dateTime = weather?.dateTime;
    final time = dateTime?.timeHm ?? '';

    final condition = weather?.conditions.firstOrNull;
    final iconCode = condition?.iconCode ?? '';
    final description = condition?.description ?? '';

    final temperature = weather?.temperature.current.round() ?? 0;
    final city = weather?.cityName ?? '';
    final country = weather?.info.country ?? '';

    return Column(
      children: [
        /// Weather icon + temperature row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImageWidget(imageUrl: '${Constants.iconBaseUrl}$iconCode@2x.png'),
            const SizedBox(width: 10),
            Text('$temperature°', style: AppTextStyle.medium18.copyWith(fontSize: 50)),
          ],
        ),

        const SizedBox(height: 12),

        /// Weather description (e.g., "clear sky")
        Text(description, style: AppTextStyle.regular16.copyWith(fontSize: 24, color: AppColors.colorPureWhite)),

        const SizedBox(height: 4),

        /// City, country, and last measurement time
        Text('$city, $country  | $time', style: AppTextStyle.regular16),
      ],
    );
  }
}

/// List of secondary weather characteristics: feels like, humidity,
/// wind speed, pressure.
///
/// Displayed in a responsive Wrap layout (2 columns automatically).
class _WeatherListWidget extends StatelessWidget {
  const _WeatherListWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<WeatherBloc>();
    final temperature = bloc.state.weather?.temperature;
    final wind = bloc.state.weather?.wind;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        /// "Feels like" card
        WeatherCardWidget(
          title: 'Відчувається як',
          value: '${temperature?.feelsLike.round() ?? 0}°',
          icon: Icons.thermostat_rounded,
        ),

        /// Humidity
        WeatherCardWidget(title: 'Вологість', value: '${temperature?.humidity ?? 0}%', icon: Icons.water_drop_rounded),

        /// Wind
        WeatherCardWidget(title: 'Вітер', value: '${wind?.speed ?? 0} м/с', icon: Icons.wind_power_rounded),

        /// Pressure
        WeatherCardWidget(title: 'Тиск', value: '${temperature?.pressure ?? 0} hPa', icon: Icons.speed_rounded),
      ],
    );
  }
}
