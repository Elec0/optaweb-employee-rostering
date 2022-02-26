import moment, { Moment } from "moment";

/*
 * Copyright 2019 Red Hat, Inc. and/or its affiliates.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
export function modulo(n: number, base: number) {
  const positiveBase = Math.abs(base);
  return ((n % positiveBase) + positiveBase) % positiveBase;
}


export function getCalendarDateRange(firstDate: string | Moment): [Date, Date] {
  const startDate = moment(firstDate).startOf('month').startOf('week').toDate();
  const endDate = moment(firstDate).endOf('month').endOf('week').toDate();
  return [startDate, endDate];
}
