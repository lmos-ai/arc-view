/*
 * Copyright 2022: Patrick Whelan
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *          http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */
import 'package:flutter/material.dart';

class VGap extends StatelessWidget {
  const VGap({super.key}) : factor = 2;
  const VGap.times(this.factor, {super.key});
  const VGap.large({super.key}) : factor = 32;
  const VGap.medium({super.key}) : factor = 12;
  const VGap.small({super.key}) : factor = 4;

  final int? factor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: (factor ?? 2) * 4);
  }
}

class HGap extends StatelessWidget {
  const HGap({super.key}) : factor = 2;
  const HGap.times(this.factor, {super.key});
  const HGap.large({super.key}) : factor = 32;
  const HGap.medium({super.key}) : factor = 12;
  const HGap.small({super.key}) : factor = 4;

  final int factor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: factor * 4);
  }
}
