import React from "react";
import { useLiveQuery } from "./live-api-slice";
import { ResponsiveLine } from "@nivo/line";
import { useParams } from "react-router-dom";
const LivePage = () => {
  const empty = <div></div>;
  const { name = "" } = useParams<{ name: string }>();
  if (!name) return empty;

  const { data } = useLiveQuery(name);
  return !data || data.serie.data.length < 1 ? (
    empty
  ) : (
    <div className="container h-2/3 mx-auto">
      <ResponsiveLine
        data={[data.serie, data.perMinuteSerie]}
        margin={{ left: 80, bottom: 50, top: 50 }}
        xScale={{
          type: "time",
          format: "%Y-%m-%dT%H:%M:%S.%LZ",
          precision: "second",
          useUTC: false,
        }}
        xFormat={"time:%H:%M:%S"}
        yScale={{
          type: "linear",
          min: data.minValue,
          max: data.maxValue,
          stacked: false,
        }}
        yFormat={">-$.2f"}
        axisBottom={{
          format: "%H:%M:%S",
          tickValues: "every 1 minutes",
        }}
        axisLeft={{
          format: (v) =>
            `${v.toLocaleString("en-US", {
              style: "currency",
              currency: "USD",
            })}`,
          tickValues: 10,
        }}
        // axisLeft={null}
        pointLabelYOffset={-10}
        enableGridX={false}
        enableGridY={true}
        curve="monotoneX"
        useMesh={true}
        isInteractive={true}
        animate={false}
        crosshairType={"x"}
        enableSlices={"x"}
        enablePoints={false}
      />
    </div>
  );
};
export default LivePage;
