import { sleep } from "k6";
import http from "k6/http";

export const options = {
  systemTags: ["vu", "iter"],
};

export default function () {
  http.get("https://test.k6.io");
  sleep(0.5);
}
